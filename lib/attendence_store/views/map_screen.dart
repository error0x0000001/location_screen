import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapScreen extends StatefulWidget {

  const MapScreen({super.key, required this.userId});
  final int userId;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng myPoint;
  bool isLoading = false;
  List<dynamic> members = [];
  List<dynamic> previousLocations = [];

  @override
  void initState() {
    myPoint = defaultPoint;
    super.initState();
    loadMemberLocations();
  }

  final defaultPoint = const LatLng(28.6139, 77.2090); // Central point in Delhi

  List<LatLng> points = [];
  List<Marker> markers = [];

  Future<void> loadMemberLocations() async {
    final response = await rootBundle.loadString('assets/members.json');
    final List<dynamic> data = jsonDecode(response);

    setState(() {
      members = data;
      selectUser(widget.userId); // Select the user and show the marker
    });
  }

  void selectUser(int userId) {
    final selectedMember = members.firstWhere((member) => member['id'] == userId);
    final currentLocation = selectedMember['currentLocation'];
    final point = LatLng(currentLocation['latitude'], currentLocation['longitude']);

    setState(() {
      markers = [
        Marker(
          point: point,
          width: 80,
          height: 80,
          child: IconButton(
            icon: const Icon(Icons.location_on),
            color: Colors.black,
            iconSize: 45,
            onPressed: () {
              // Handle marker tap
              print("Member ID: ${selectedMember['id']}, Name: ${selectedMember['name']}");
            },
          ),
        ),
      ];
      myPoint = point;
      mapController.move(point, 16);
      previousLocations = List<dynamic>.from(selectedMember['previousLocations']);
    });
  }

  Future<void> getCoordinates(LatLng lat1, LatLng lat2) async {
    setState(() {
      isLoading = true;
    });

    final client = OpenRouteService(
      apiKey: 'YOUR-API-KEY',
    );

    final routeCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate:
          ORSCoordinate(latitude: lat1.latitude, longitude: lat1.longitude),
      endCoordinate:
          ORSCoordinate(latitude: lat2.latitude, longitude: lat2.longitude),
    );

    final routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();

    setState(() {
      points = routePoints;
      isLoading = false;
    });
  }

  final MapController mapController = MapController();

  void _handleTap(LatLng latLng) {
    setState(() {
      if (markers.length < 2) {
        markers.add(
          Marker(
            point: latLng,
            width: 80,
            height: 80,
            child: Draggable(
              feedback: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                color: Colors.black,
                iconSize: 45,
              ),
              onDragEnd: (details) {
                setState(() {
                  print(
                      'Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}',);
                });
              },
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                color: Colors.black,
                iconSize: 45,
              ),
            ),
          ),
        );
      }

      if (markers.length == 1) {
        var zoomLevel = 16.5;
        mapController.move(latLng, zoomLevel);
      }

      if (markers.length == 2) {
        // Adicionar um pequeno atraso antes de exibir o efeito de processo
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isLoading = true;
          });
        });

        getCoordinates(markers[0].point, markers[1].point);

        // Calcular a extensão (bounding box) que envolve os dois pontos marcados
        var bounds = LatLngBounds.fromPoints(
            markers.map((marker) => marker.point).toList(),);
        // Fazer um zoom out para que a extensão se ajuste à tela
        mapController.fitBounds(bounds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              zoom: 16,
              center: myPoint,
              onTap: (tapPosition, latLng) => _handleTap(latLng),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: markers,
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    color: Colors.black,
                    strokeWidth: 5,
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20.0,
            left: MediaQuery.of(context).size.width / 2 - 110,
            child: Align(
              child: TextButton(
                onPressed: () {
                  if (markers.isEmpty) {
                    print('Mark points on the map');
                  } else {
                    setState(() {
                      markers = [];
                      points = [];
                    });
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),),
                  child: Center(
                    child: Text(
                      markers.isEmpty ? 'Mark points on the map' : 'Clear map',
                      style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 0.5,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: previousLocations.length,
                  itemBuilder: (BuildContext context, int index) {
                    final location = previousLocations[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.location_on, color: theme.colorScheme.primary),
                          title: Text(
                            'Latitude: ${location['latitude']}, Longitude: ${location['longitude']}',
                            style: TextStyle(color: theme.colorScheme.onSurface),
                          ),
                          subtitle: Text(
                            'Timestamp: ${location['timestamp']}',
                            style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
                          ),
                        ),
                        Divider(
                          color: theme.dividerColor,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: theme.primaryColor,
            onPressed: () {
              mapController.move(mapController.center, mapController.zoom + 1);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: theme.primaryColor,
            onPressed: () {
              mapController.move(mapController.center, mapController.zoom - 1);
            },
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
