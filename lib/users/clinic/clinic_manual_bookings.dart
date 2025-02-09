import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClinicManualBookingsScreen extends StatefulWidget {
  @override
  _ClinicManualBookingsScreenState createState() => _ClinicManualBookingsScreenState();
}

class _ClinicManualBookingsScreenState extends State<ClinicManualBookingsScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedBranch = "City Medical Center";
  String selectedBed = "Bed 1";

  // Mocked branch settings: Number of beds & time slot intervals
  final Map<String, dynamic> branchSettings = {
    "City Medical Center": {"beds": ["Bed 1", "Bed 2"], "interval": 30}, // 30-minute intervals
    "Downtown Clinic": {"beds": ["Bed 1", "Bed 2", "Bed 3"], "interval": 60}, // 60-minute intervals
    "Health & Wellness Clinic": {"beds": ["Bed 1"], "interval": 45}, // 45-minute intervals
  };

  Map<String, Set<String>> blockedSlots = {}; // Slots blocked by the clinic
  Map<String, Set<String>> bookedSlots = {}; // Slots booked via the app

  @override
  Widget build(BuildContext context) {
    List<String> beds = branchSettings[selectedBranch]?["beds"] ?? ["Bed 1"];
    int interval = branchSettings[selectedBranch]?["interval"] ?? 30;

    // Generate time slots based on interval
    List<String> timeSlots = _generateTimeSlots(interval);

    return Scaffold(
      appBar: AppBar(
        title: Text("Manual Bookings"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveBlockedSlots,
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Picker Row
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                DateTime date = DateTime.now().add(Duration(days: index));
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selectedDate.day == date.day ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.E().format(date),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: selectedDate.day == date.day ? Colors.white : Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedDate.day == date.day ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Branch Selector
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: "Select Branch"),
            value: selectedBranch,
            onChanged: (value) => setState(() => selectedBranch = value!),
            items: branchSettings.keys.map((branch) {
              return DropdownMenuItem(value: branch, child: Text(branch));
            }).toList(),
          ),

          // Bed Selector
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: "Select Bed"),
            value: selectedBed,
            onChanged: (value) => setState(() => selectedBed = value!),
            items: beds.map((bed) {
              return DropdownMenuItem(value: bed, child: Text(bed));
            }).toList(),
          ),

          SizedBox(height: 10),

          // Time Slots Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Three columns for a grid layout
                childAspectRatio: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                String timeSlot = timeSlots[index];
                bool isBlocked = blockedSlots[selectedBed]?.contains(timeSlot) ?? false;
                bool isBooked = bookedSlots[selectedBed]?.contains(timeSlot) ?? false;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isBooked) return; // Clinics cannot unblock booked slots

                      if (!blockedSlots.containsKey(selectedBed)) {
                        blockedSlots[selectedBed] = {};
                      }
                      if (isBlocked) {
                        blockedSlots[selectedBed]?.remove(timeSlot);
                      } else {
                        blockedSlots[selectedBed]?.add(timeSlot);
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isBooked
                          ? Colors.green // Booked via the app (Clinics cannot change this)
                          : isBlocked
                              ? Colors.red // Blocked by the clinic
                              : Colors.blue[100], // Free slot
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      timeSlot,
                      style: TextStyle(
                        color: isBooked || isBlocked ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Generate time slots dynamically based on interval setting
  List<String> _generateTimeSlots(int interval) {
    List<String> timeSlots = [];
    DateTime startTime = DateTime(2023, 1, 1, 6, 0); // Start at 6:00 AM
    DateTime endTime = DateTime(2023, 1, 1, 20, 0); // End at 8:00 PM

    while (startTime.isBefore(endTime)) {
      timeSlots.add(DateFormat.jm().format(startTime));
      startTime = startTime.add(Duration(minutes: interval));
    }

    return timeSlots;
  }

  void _saveBlockedSlots() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Blocked slots saved successfully!")),
    );
  }
}
