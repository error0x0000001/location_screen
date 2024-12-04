import 'package:flutter/material.dart';
import 'package:location_screen/attendence_store/data/product_repo.dart';
import 'package:location_screen/attendence_store/model/members.dart';
import 'package:location_screen/attendence_store/views/map_screen.dart';
import 'package:location_screen/themes/styles.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class AttendenceView extends StatefulWidget {
  const AttendenceView({super.key});

  @override
  _AttendenceViewState createState() => _AttendenceViewState();
}

class _AttendenceViewState extends State<AttendenceView> {
  DateTime _selectedDate = DateTime.now();

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return Colors.green;
      case 'not found':
        return Colors.grey;
      case 'absent':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _previousDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _nextDate() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATTENDENCE'),
        backgroundColor: Styles.lightColorScheme.primary, // Set the AppBar color
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40, // Decrease the height of the date selector
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _previousDate,
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd').format(_selectedDate),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: _nextDate,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Member>>(
              future: ProductRepo.loadAllMembers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No members found'));
                } else {
                  final membersList = snapshot.data!;
                  return ListView.builder(
                    itemCount: membersList.length,
                    itemBuilder: (context, index) {
                      final member = membersList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(member.profilePicture),
                          ),
                          title: Text(member.name),
                          subtitle: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(member.status),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(member.status),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.info_outline),
                                onPressed: () {
                                  // Handle About button press
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('About ${member.name}'),
                                      content: Text('Status: ${member.status}\nCurrent Location: ${member.currentLocation.latitude}, ${member.currentLocation.longitude}'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.my_location, color: Colors.blue), // Set the icon color
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MapScreen(userId: member.id,),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
