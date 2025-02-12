import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyServicesScreen extends StatefulWidget {
  final String role; // Clinic, Coach, or Academy

  MyServicesScreen({super.key, required this.role});

  @override
  _MyServicesScreenState createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {
  final List<Map<String, dynamic>> services = [
    {
      'name': 'Private Swimming Lessons',
      'price': '\$60 per hour',
      'description': 'One-on-one coaching for advanced swimmers.',
      'photo': null,
    },
    {
      'name': 'Water Therapy Session',
      'price': '\$40 per session',
      'description': 'Hydrotherapy for rehabilitation and muscle recovery.',
      'photo': null,
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
            child: services.isEmpty
                ? const Center(child: Text("No services added yet."))
                : ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: service['photo'] != null
                              ? Image.file(
                                  File(service['photo']),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image, size: 50, color: Colors.grey),
                          title: Text(service['name']!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: ${service['price']}'),
                              Text('Description: ${service['description']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _showEditServiceDialog(index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteService(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddServiceDialog();
              },
              child: const Text('Add Service'),
            ),
          ),
        ],
      ),
    );
  }

  // Function to delete a service
  void _deleteService(int index) {
    setState(() {
      services.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Service deleted successfully!")),
    );
  }

  // Function to show Add Service Dialog
  void _showAddServiceDialog() {
    _showServiceDialog(isEditing: false);
  }

  // Function to show Edit Service Dialog
  void _showEditServiceDialog(int index) {
    _showServiceDialog(isEditing: true, index: index);
  }

  // Function to handle both Add and Edit operations
  void _showServiceDialog({required bool isEditing, int? index}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    String? imagePath;

    // If editing, populate fields with existing data
    if (isEditing && index != null) {
      nameController.text = services[index]['name'];
      priceController.text = services[index]['price'];
      descriptionController.text = services[index]['description'];
      imagePath = services[index]['photo'];
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? "Edit Service" : "Add Service"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Service Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              const SizedBox(height: 10),

              // Image Picker Button
              ElevatedButton.icon(
                onPressed: () async {
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      imagePath = pickedFile.path;
                    });
                  }
                },
                icon: const Icon(Icons.image),
                label: const Text("Upload Photo"),
              ),

              // Preview Image
              imagePath != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Image.file(
                        File(imagePath!),
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                  if (isEditing && index != null) {
                    _editService(index, nameController.text, priceController.text, descriptionController.text, imagePath);
                  } else {
                    _addService(nameController.text, priceController.text, descriptionController.text, imagePath);
                  }
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill in all required fields!")),
                  );
                }
              },
              child: Text(isEditing ? "Save Changes" : "Add"),
            ),
          ],
        );
      },
    );
  }

  // Function to add a new service
  void _addService(String name, String price, String description, String? photoPath) {
    setState(() {
      services.add({
        'name': name,
        'price': price,
        'description': description.isNotEmpty ? description : "No description provided",
        'photo': photoPath,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Service added successfully!")),
    );
  }

  // Function to edit an existing service
  void _editService(int index, String name, String price, String description, String? photoPath) {
    setState(() {
      services[index] = {
        'name': name,
        'price': price,
        'description': description.isNotEmpty ? description : "No description provided",
        'photo': photoPath ?? services[index]['photo'],
      };
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Service updated successfully!")),
    );
  }
}
