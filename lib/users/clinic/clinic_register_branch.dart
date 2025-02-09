import 'package:flutter/material.dart';

class ClinicRegisterBranchScreen extends StatefulWidget {
  @override
  _ClinicRegisterBranchScreenState createState() => _ClinicRegisterBranchScreenState();
}

class _ClinicRegisterBranchScreenState extends State<ClinicRegisterBranchScreen> {
  final TextEditingController _branchNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bedsController = TextEditingController();
  int? selectedBeds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Clinic Branch"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Branch Name Input
            TextFormField(
              controller: _branchNameController,
              decoration: InputDecoration(labelText: "Branch Name"),
            ),

            SizedBox(height: 10),

            // Location Input
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: "Location (GPS URL)"),
            ),

            SizedBox(height: 10),

            // Phone Number Input
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Branch Phone Number"),
              keyboardType: TextInputType.phone,
            ),

            SizedBox(height: 10),

            // Number of Beds Input
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: "Number of Beds"),
              value: selectedBeds,
              onChanged: (value) {
                setState(() {
                  selectedBeds = value;
                });
              },
              items: List.generate(10, (index) => index + 1) // Allows selection of 1-10 beds
                  .map((beds) => DropdownMenuItem(
                        value: beds,
                        child: Text("$beds Beds"),
                      ))
                  .toList(),
            ),

            SizedBox(height: 20),

            // Register Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_branchNameController.text.isEmpty ||
                      _locationController.text.isEmpty ||
                      _phoneController.text.isEmpty ||
                      selectedBeds == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all required fields")),
                    );
                    return;
                  }

                  // Save Branch Information
                  _saveBranch();
                },
                child: Text("Register Branch"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveBranch() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Branch Registered Successfully!")),
    );
  }
}
