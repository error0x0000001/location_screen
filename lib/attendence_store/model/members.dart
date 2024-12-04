class Member {

  Member({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.status,
    required this.currentLocation,
    required this.previousLocations,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as int,
      name: json['name'] as String,
      profilePicture: json['profilePicture'] as String,
      status: json['status'] as String,
      currentLocation: Location.fromJson(json['currentLocation'] as Map<String, dynamic>),
      previousLocations: (json['previousLocations'] as List)
          .map((location) => Location.fromJson(location as Map<String, dynamic>))
          .toList(),
    );
  }
  final int id;
  final String name;
  final String profilePicture;
  final String status;
  final Location currentLocation;
  final List<Location> previousLocations;
}

class Location {

  Location({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      timestamp: json['timestamp'] as String,
    );
  }
  final double latitude;
  final double longitude;
  final String timestamp;
}