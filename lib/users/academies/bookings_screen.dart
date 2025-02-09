import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatefulWidget {
  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedBranch = "All";

  final List<String> branches = ["All", "SR Padel x ZED", "Golf Porto", "Hacienda"];

  final List<Map<String, dynamic>> bookings = [
    {
      'branch': "SR Padel x ZED",
      'service': "Private Lesson",
      'time': "10:00 AM - 11:00 AM",
      'clients': [
        {"name": "John Doe", "contact": "+1 234 567 890"},
        {"name": "Jane Smith", "contact": "+1 876 543 210"},
      ]
    },
    {
      'branch': "Golf Porto",
      'service': "Group Class",
      'time': "2:00 PM - 3:00 PM",
      'clients': [
        {"name": "Michael Jordan", "contact": "+1 345 678 901"},
      ]
    },
    {
      'branch': "Hacienda",
      'service': "Kids Swimming Class",
      'time': "5:00 PM - 6:00 PM",
      'clients': [
        {"name": "Alice Brown", "contact": "+1 789 012 345"},
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
        title: Text("Bookings"),
        centerTitle: true,
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: branches.map((branch) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBranch = branch;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
              }).toList(),
            ),
          ),

          SizedBox(height: 10),

          // List of Bookings
          Expanded(
            child: filteredBookings.isEmpty
                ? Center(
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
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking['service'],
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Time: ${booking['time']}",
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Clients: ${booking['clients'].length}",
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.add, color: Colors.blue),
                                  onPressed: () {
                                    _showClientList(context, booking['clients']);
                                  },
                                ),
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

  // Pop-up to show the list of clients
  void _showClientList(BuildContext context, List<Map<String, String>> clients) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Clients"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: clients.map((client) {
              return ListTile(
                title: Text(client['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(client['contact']!, style: TextStyle(color: Colors.black54)),
                leading: Icon(Icons.person, color: Colors.blue),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
