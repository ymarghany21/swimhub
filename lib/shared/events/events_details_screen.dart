import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(event['photo'], height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              event['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Location: ${event['location']}'),
            Text('Price: ${event['price']}'),
            const SizedBox(height: 16),
            const Text(
              'Description: This is a placeholder description for the event.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Booking logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Event booked successfully!')),
                );
              },
              child: const Text('Book Event'),
            ),
          ],
        ),
      ),
    );
  }
}
