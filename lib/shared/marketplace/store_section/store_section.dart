import 'package:flutter/material.dart';
import 'store_details_screen.dart';
import 'store_products_screen.dart';

class StoreSection extends StatelessWidget {
  final String userRole; // Role determines "Add Product" button visibility

  StoreSection({super.key, required this.userRole});

  final List<Map<String, dynamic>> _stores = [
    {
      'photo': 'https://via.placeholder.com/150',
      'name': 'Dive Shop',
      'location': 'San Diego, USA',
    },
    {
      'photo': 'https://via.placeholder.com/150',
      'name': 'Swim Club Store',
      'location': 'Miami, USA',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _stores.length,
        itemBuilder: (context, index) {
          final store = _stores[index];
          return Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(store['photo'], height: 150, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(store['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Location: ${store['location']}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoreProductsScreen(
                                    storeName: store['name'],
                                    userRole: userRole,
                                  ),
                                ),
                              );
                            },
                            child: const Text('View Products'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StoreDetailsScreen(store: store),
                                ),
                              );
                            },
                            child: const Text('View Store Details'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: (userRole == 'Store')
          ? FloatingActionButton.extended(
              onPressed: () {
                // Add Product button for Store role
              },
              label: const Text('Add Product'),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }
}
