import 'package:flutter/material.dart';

class ManualBookingsButton extends StatefulWidget {
  final List<Map<String, dynamic>> userListings;

  ManualBookingsButton({required this.userListings});

  @override
  _ManualBookingsButtonState createState() => _ManualBookingsButtonState();
}

class _ManualBookingsButtonState extends State<ManualBookingsButton> {
  Map<String, int> bookingCounts = {};

  @override
  void initState() {
    super.initState();
    for (var listing in widget.userListings) {
      bookingCounts[listing['service']] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showUserListings(context);
      },
      child: Text("Manual Bookings"),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showUserListings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Your Listings"),
          content: widget.userListings.isEmpty
              ? Text("You have no listings available.")
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.userListings.map((listing) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(listing['service']),
                        subtitle: Text(
                          "Time: ${listing['time']}\nBranch: ${listing['branch']}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${bookingCounts[listing['service']]}"),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.blue),
                              onPressed: () {
                                _incrementBooking(listing['service']);
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _bookListing(context, listing);
                              },
                              child: Text("Book"),
                            ),
                          ],
                        ),
                      ),
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

  void _incrementBooking(String serviceName) {
    setState(() {
      bookingCounts[serviceName] = (bookingCounts[serviceName] ?? 0) + 1;
    });
  }

  void _bookListing(BuildContext context, Map<String, dynamic> listing) {
    int bookedCount = bookingCounts[listing['service']] ?? 0;
    if (bookedCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You must add at least 1 booking before confirming.")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Booking Confirmed"),
          content: Text(
            "You have successfully booked ${bookedCount} slots for:\n${listing['service']} at ${listing['time']}",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
