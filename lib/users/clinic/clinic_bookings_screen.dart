import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClinicBookingsScreen extends StatefulWidget {
  @override
  _ClinicBookingsScreenState createState() => _ClinicBookingsScreenState();
}

class _ClinicBookingsScreenState extends State<ClinicBookingsScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedBranch = "All"; // Default selection is "All"

  final List<String> branches = ["All", "City Medical Center", "Downtown Clinic", "Health & Wellness Clinic"];

  final List<Map<String, dynamic>> bookings = [
    {
      'time': "9:00 AM - 10:00 AM",
      'branch': "City Medical Center",
      'beds': [
        {
          "bed": "Bed 1",
          "clients": [
            {"name": "John Doe", "contact": "+1 234 567 890", "services": ["General Checkup"]},
            {"name": "Jane Smith", "contact": "+1 876 543 210", "services": ["Physical Therapy", "X-Ray"]},
          ]
        },
        {
          "bed": "Bed 2",
          "clients": [
            {"name": "Michael Brown", "contact": "+1 789 012 345", "services": ["Blood Test"]},
          ]
        }
      ]
    },
    {
      'time': "1:00 PM - 2:00 PM",
      'branch': "Downtown Clinic",
      'beds': [
        {
          "bed": "Bed 3",
          "clients": [
            {"name": "Alice Green", "contact": "+1 543 210 876", "services": ["Dental Checkup"]},
          ]
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredBookings = bookings.where((booking) {
      return selectedBranch == "All" || booking['branch'] == selectedBranch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Clinic Bookings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Date Picker Row (Horizontal Scroll)
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

          // Branch Selector (Horizontal Scroll)
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: branches.length,
              itemBuilder: (context, index) {
                String branch = branches[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBranch = branch;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: selectedBranch == branch ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      branch,
                      style: TextStyle(
                          color: selectedBranch == branch ? Colors.white : Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // List of Time Slots (Cards)
          Expanded(
            child: filteredBookings.isEmpty
                ? const Center(
                    child: Text(
                      "No bookings available for this day.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Time Slot & Branch Name
                              Text(
                                "${booking['branch']}",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Time: ${booking['time']}",
                                style: const TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                              const SizedBox(height: 5),

                              // Table Header
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(child: Text("Bed", style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(child: Text("Client", style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(child: Text("Contact", style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(child: Text("Service(s)", style: TextStyle(fontWeight: FontWeight.bold))),
                                ],
                              ),
                              const Divider(),

                              // Bed-wise Patient List
                              Column(
                                children: booking['beds'].map<Widget>((bedData) {
                                  return Column(
                                    children: bedData['clients'].map<Widget>((client) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Text(bedData['bed'])),
                                          Expanded(child: Text(client['name'])),
                                          Expanded(child: Text(client['contact'])),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: List.generate(client['services'].length, (index) {
                                                return Text("- ${client['services'][index]}");
                                              }),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                }).toList(),
                              ),
                            ],
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
}
