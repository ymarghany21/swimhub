import 'package:flutter/material.dart';

class PostProductScreen extends StatefulWidget {
  const PostProductScreen({super.key});

  @override
  _PostProductScreenState createState() => _PostProductScreenState();
}

class _PostProductScreenState extends State<PostProductScreen> {
  final _itemTypeController = TextEditingController();
  final _brandController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isNew = true;

  void _postProduct() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product Posted Successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _itemTypeController,
              decoration: const InputDecoration(labelText: 'Item Type'),
            ),
            TextFormField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description (Optional)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Condition:'),
                Row(
                  children: [
                    const Text('New'),
                    Switch(
                      value: !_isNew,
                      onChanged: (value) {
                        setState(() {
                          _isNew = !value;
                        });
                      },
                    ),
                    const Text('Used'),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _postProduct,
              child: const Text('Post Product'),
            ),
          ],
        ),
      ),
    );
  }
}
