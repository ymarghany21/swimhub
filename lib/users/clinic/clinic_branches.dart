import 'package:flutter/material.dart';
import '../clinic/clinic_branches.dart';
import '../clinic/clinic_register_branch.dart';

class MyBranchesScreen extends StatelessWidget {
  final String role;

  MyBranchesScreen({super.key, required this.role});

  final List<Map<String, dynamic>> branches = [
    {
      'name': 'Central Branch',
      'specialty': 'Swimming Training',
      'location': 'New York',
      'gpsUrl': 'https://maps.google.com/...',
      'phone': '123-456-7890',
      'services': ['Swimming Lessons', 'Gym Facilities'],
      'cancellationPolicy': 48,
      'timeSlotInterval': 30,
    },
    {
      'name': 'East Branch',
      'specialty': 'Therapy & Yoga',
      'location': 'Los Angeles',
      'gpsUrl': 'https://maps.google.com/...',
      'phone': '987-654-3210',
      'services': ['Therapy Sessions', 'Yoga Classes'],
      'cancellationPolicy': 72,
      'timeSlotInterval': 60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Branches'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: branches.length,
        itemBuilder: (context, index) {
          final branch = branches[index];
          return Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              title: Text(branch['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (branch['specialty'] != null)
                    Text('Specialty: ${branch['specialty']}'),
                  Text('Location: ${branch['location']}'),
                  Text('Phone: ${branch['phone']}'),
                  Text('Cancellation Policy: ${branch['cancellationPolicy']} Hours'),
                  Text('Time Slot Interval: ${branch['timeSlotInterval']} Minutes'),
                  Text(
                    'Services: ${branch['services'].join(", ")}',
                  ),
                ],
              ),
              trailing: const Icon(Icons.edit),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterBranchScreen(
                      role: role,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
