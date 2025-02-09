import 'package:flutter/material.dart';

class StoreProductsScreen extends StatelessWidget {
  final String storeName;

  StoreProductsScreen({super.key, required this.storeName, required String userRole});

  final List<Map<String, dynamic>> _products = [
    {
      'itemType': 'Training Fins',
      'photos': ['https://via.placeholder.com/150'],
      'price': '\$35',
    },
    {
      'itemType': 'Swim Caps',
      'photos': ['https://via.placeholder.com/150'],
      'price': '\$10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$storeName - Products')),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product['photos'][0], height: 150, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['itemType'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Price: ${product['price']}'),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to Cart!')),
                          );
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
