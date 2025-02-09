import 'package:flutter/material.dart';

class RegisterBranchScreen extends StatefulWidget {
  final String role;

  const RegisterBranchScreen({super.key, required this.role});

  @override
  _RegisterBranchScreenState createState() => _RegisterBranchScreenState();
}

class _RegisterBranchScreenState extends State<RegisterBranchScreen> {
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _locationController = TextEditingController();
  final _gpsUrlController = TextEditingController();
  final _phoneController = TextEditingController();

  int? selectedCancellationPolicy;
  int? selectedTimeSlotInterval;
  bool changesMade = false;

  List<String> services = [
    'Swimming Lessons',
    'Gym Facilities',
    'Therapy Sessions',
    'Yoga Classes',
    'Diving Courses',
  ];
  List<bool> selectedServices = [false, false, false, false, false];

  final List<int> cancellationPolicies = [24, 48, 72, 96, 120];
  final List<int> timeSlotIntervals = [15, 30, 45, 60, 90];

  @override
  void dispose() {
    _nameController.dispose();
    _specialtyController.dispose();
    _locationController.dispose();
    _gpsUrlController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void saveBranch() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Branch Registered/Updated Successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register ${widget.role == "Online Academy" ? "Academy" : "Branch"}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (_) => setState(() => changesMade = true),
            ),
            if (widget.role != 'Clinic' && widget.role != 'Online Academy')
              TextFormField(
                controller: _specialtyController,
                decoration: const InputDecoration(labelText: 'Specialty'),
                onChanged: (_) => setState(() => changesMade = true),
              ),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
              onChanged: (_) => setState(() => changesMade = true),
            ),
            TextFormField(
              controller: _gpsUrlController,
              decoration: const InputDecoration(labelText: 'GPS URL'),
              onChanged: (_) => setState(() => changesMade = true),
            ),
            if (widget.role != 'Online Store')
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onChanged: (_) => setState(() => changesMade = true),
              ),
            if (widget.role == 'Coach' || widget.role == 'Clinic' || widget.role == 'Academy')
              Column(
                children: [
                  DropdownButtonFormField<int>(
                    value: selectedCancellationPolicy ?? cancellationPolicies.first,
                    items: cancellationPolicies.map((hours) {
                      return DropdownMenuItem(
                        value: hours,
                        child: Text('$hours Hours'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCancellationPolicy = value;
                        changesMade = true;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Cancellation Policy (Hours)'),
                  ),
                  DropdownButtonFormField<int>(
                    value: selectedTimeSlotInterval ?? timeSlotIntervals.first,
                    items: timeSlotIntervals.map((minutes) {
                      return DropdownMenuItem(
                        value: minutes,
                        child: Text('$minutes Minutes'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTimeSlotInterval = value;
                        changesMade = true;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Time Slot Interval (Minutes)'),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            const Text(
              'Services Available at this Branch:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...List.generate(services.length, (index) {
              return CheckboxListTile(
                title: Text(services[index]),
                value: selectedServices[index],
                onChanged: (value) {
                  setState(() {
                    selectedServices[index] = value!;
                    changesMade = true;
                  });
                },
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: changesMade ? saveBranch : null,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}