import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBranchesScreen extends StatefulWidget {
  final String role;

  MyBranchesScreen({super.key, required this.role});

  @override
  _MyBranchesScreenState createState() => _MyBranchesScreenState();
}

class _MyBranchesScreenState extends State<MyBranchesScreen> {
  List<Map<String, dynamic>> branches = [
    {
      'name': 'Central Branch',
      'location': 'New York',
      'gpsUrl': 'https://maps.google.com/...',
      'phone': '123-456-7890',
      'services': ['Swimming Lessons', 'Gym Facilities'],
      'cancellationPolicy': 48,
      'timeSlotInterval': 30,
      'beds': 5,
      'bookings': 10,
      'workingHours': {'start': "08:00 AM", 'end': "06:00 PM"}, // Working hours
    },
    {
      'name': 'East Branch',
      'location': 'Los Angeles',
      'gpsUrl': 'https://maps.google.com/...',
      'phone': '987-654-3210',
      'services': ['Therapy Sessions', 'Yoga Classes'],
      'cancellationPolicy': 72,
      'timeSlotInterval': 60,
      'beds': 8,
      'bookings': 0,
      'workingHours': {'start': "09:00 AM", 'end': "05:00 PM"},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Branches'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: branches.isEmpty
                ? const Center(child: Text("No branches registered yet."))
                : ListView.builder(
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
                              Text('Location: ${branch['location']}'),
                              Text('Phone: ${branch['phone']}'),
                              Text('Beds Available: ${branch['beds']}'),
                              Text('Cancellation Policy: ${branch['cancellationPolicy']} Hours'),
                              Text('Time Slot Interval: ${branch['timeSlotInterval']} Minutes'),
                              Text('Services: ${branch['services'].join(", ")}'),
                              Text('Active Bookings: ${branch['bookings']}'),
                              Text(
                                  'Working Hours: ${branch['workingHours']['start']} - ${branch['workingHours']['end']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Edit Button
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _showEditBranchDialog(index);
                                },
                              ),

                              // Delete Button
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _confirmDeleteBranch(index, branch['bookings']);
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
                _showAddBranchDialog();
              },
              child: const Text('Register New Branch'),
            ),
          ),
        ],
      ),
    );
  }

  // Function to Confirm Deletion
  void _confirmDeleteBranch(int index, int bookings) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Branch"),
          content: Text(bookings > 0
              ? "⚠ Warning: This branch has $bookings active bookings. Deleting it is not recommended!"
              : "Are you sure you want to delete this branch? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteBranch(index);
                Navigator.pop(context);
              },
              child: const Text("Delete"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  // Function to Delete Branch
  void _deleteBranch(int index) {
    setState(() {
      branches.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Branch deleted successfully!")),
    );
  }

  // Function to Show Add Branch Dialog
  void _showAddBranchDialog() {
    _showBranchDialog(isEditing: false);
  }

  // Function to Show Edit Branch Dialog
  void _showEditBranchDialog(int index) {
    _showBranchDialog(isEditing: true, index: index);
  }

  // Function to Handle Adding & Editing a Branch
  void _showBranchDialog({required bool isEditing, int? index}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    int? selectedBeds = 5;
    int? selectedTimeSlotInterval = 30;
    int? selectedCancellationPolicy = 48;
    String startTime = "08:00 AM";
    String endTime = "06:00 PM";

    if (isEditing && index != null) {
      var branch = branches[index];
      nameController.text = branch['name'];
      locationController.text = branch['location'];
      phoneController.text = branch['phone'];
      selectedBeds = branch['beds'];
      selectedTimeSlotInterval = branch['timeSlotInterval'];
      selectedCancellationPolicy = branch['cancellationPolicy'];
      startTime = branch['workingHours']['start'];
      endTime = branch['workingHours']['end'];
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? "Edit Branch" : "Register Branch"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Branch Name")),
              const SizedBox(height: 10),
              TextField(controller: locationController, decoration: const InputDecoration(labelText: "Location (GPS URL)")),
              const SizedBox(height: 10),
              TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Branch Phone Number"), keyboardType: TextInputType.phone),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: "Number of Beds"),
                value: selectedBeds,
                onChanged: (value) => setState(() => selectedBeds = value),
                items: List.generate(10, (index) => index + 1).map((beds) => DropdownMenuItem(value: beds, child: Text("$beds Beds"))).toList(),
              ),
              const SizedBox(height: 10),
              // Working Hours
              ListTile(
                title: Text("First Available Slot: $startTime"),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (picked != null) {
                    setState(() {
                      startTime = picked.format(context);
                    });
                  }
                },
              ),
              ListTile(
                title: Text("Last Available Slot: $endTime"),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (picked != null) {
                    setState(() {
                      endTime = picked.format(context);
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(isEditing ? "Save Changes" : "Add Branch"),
            ),
          ],
        );
      },
    );
  }
}
