import 'package:flutter/material.dart';

class StoreDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> store;

  const StoreDetailsScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${store['name']} Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(store['photo'], height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              store['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Location: ${store['location']}'),
            const SizedBox(height: 16),
            const Text('Branches:'),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Branch Location URL Copied!')),
                );
              },
              child: const Text('Show Branch Location'),
            ),
            const SizedBox(height: 16),
            const Text('Social Media:'),
            const Row(
              children: [
                Icon(Icons.facebook, color: Colors.blue),
                SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
