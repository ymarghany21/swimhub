import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['itemType'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['photos'][0], height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              product['itemType'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Brand: ${product['brand']}'),
            Text('Size: ${product['size']}'),
            Text('Condition: ${product['condition']}'),
            Text('Price: ${product['price']}'),
            const SizedBox(height: 16),
            Text('Location: ${product['location']}'),
            Text('Description: ${product['description'] ?? 'No Description Provided'}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Contacting Seller at ${product['phoneNumber']}')),
                );
              },
              child: const Text('Contact Seller'),
            ),
          ],
        ),
      ),
    );
  }
}
