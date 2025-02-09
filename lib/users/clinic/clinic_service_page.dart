import 'package:flutter/material.dart';

class MyServicesScreen extends StatelessWidget {
  final String role; // Clinic, Coach, or Academy

  MyServicesScreen({super.key, required this.role});

  final List<Map<String, String>> services = [
    {
      'name': 'Private Swimming Lessons',
      'price': '\$60 per hour',
      'description': 'One-on-one coaching for advanced swimmers.',
    },
    {
      'name': 'Water Therapy Session',
      'price': '\$40 per session',
      'description': 'Hydrotherapy for rehabilitation and muscle recovery.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Services'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(service['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${service['price']}'),
                        Text('Description: ${service['description']}'),
                      ],
                    ),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      // Implement Edit Functionality
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement Add Service Functionality
              },
              child: const Text('Add Service'),
            ),
          ),
        ],
      ),
    );
  }
}
