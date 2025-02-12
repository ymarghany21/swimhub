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

  // Mocked branch settings: Number of beds, working hours & time slot intervals
  final Map<String, dynamic> branchSettings = {
    "City Medical Center": {
      "beds": ["Bed 1", "Bed 2"],
      "interval": 30, // 30-minute intervals
      "workingHours": {"start": "08:00 AM", "end": "06:00 PM"},
    },
    "Downtown Clinic": {
      "beds": ["Bed 1", "Bed 2", "Bed 3"],
      "interval": 60, // 60-minute intervals
      "workingHours": {"start": "09:00 AM", "end": "05:00 PM"},
    },
    "Health & Wellness Clinic": {
      "beds": ["Bed 1"],
      "interval": 45, // 45-minute intervals
      "workingHours": {"start": "07:00 AM", "end": "07:00 PM"},
    },
  };

  Map<String, Set<String>> blockedSlots = {}; // Slots blocked by the clinic
  Map<String, Set<String>> bookedSlots = {}; // Slots booked via the app

  @override
  Widget build(BuildContext context) {
    List<String> beds = branchSettings[selectedBranch]?["beds"] ?? ["Bed 1"];
    int interval = branchSettings[selectedBranch]?["interval"] ?? 30;
    Map<String, String> workingHours = branchSettings[selectedBranch]?["workingHours"] ??
        {"start": "08:00 AM", "end": "06:00 PM"};

    // Generate time slots dynamically based on working hours & interval
    List<String> timeSlots = _generateTimeSlots(workingHours, interval);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manual Bookings"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveBlockedSlots,
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Picker Row
          SizedBox(
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
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    padding: const EdgeInsets.all(10),
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
                        const SizedBox(height: 5),
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
            decoration: const InputDecoration(labelText: "Select Branch"),
            value: selectedBranch,
            onChanged: (value) {
              setState(() {
                selectedBranch = value!;
                selectedBed = branchSettings[selectedBranch]?["beds"][0] ?? "Bed 1"; // Reset to first bed
              });
            },
            items: branchSettings.keys.map((branch) {
              return DropdownMenuItem(value: branch, child: Text(branch));
            }).toList(),
          ),

          // Bed Selector (Iterative like Date Selector)
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: beds.length,
              itemBuilder: (context, index) {
                String bed = beds[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBed = bed;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: selectedBed == bed ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      bed,
                      style: TextStyle(
                          color: selectedBed == bed ? Colors.white : Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Time Slots Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

                      blockedSlots[selectedBed] ??= {};
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
                          ? Colors.green // 🟩 Booked via the app (Clinics cannot change this)
                          : isBlocked
                              ? Colors.red // 🟥 Blocked by the clinic
                              : Colors.blue[100], // 🟦 Free slot
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

  // Generate time slots dynamically based on working hours & interval setting
  List<String> _generateTimeSlots(Map<String, String> workingHours, int interval) {
    List<String> timeSlots = [];
    DateTime startTime = _parseTime(workingHours["start"]!);
    DateTime endTime = _parseTime(workingHours["end"]!);

    while (startTime.isBefore(endTime)) {
      timeSlots.add(DateFormat.jm().format(startTime));
      startTime = startTime.add(Duration(minutes: interval));
    }

    return timeSlots;
  }

  DateTime _parseTime(String time) {
    final format = DateFormat.jm(); // 12-hour format with AM/PM
    return format.parse(time);
  }

  void _saveBlockedSlots() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Blocked slots saved successfully!")),
    );
  }
}
