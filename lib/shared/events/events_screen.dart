import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  DateTimeRange? selectedDateRange;
  RangeValues priceRange = const RangeValues(0, 200);
  String? selectedLocation;
  String? selectedEventType;

  List<Map<String, String>> events = [
    {
      'title': 'Swimming Gala',
      'date': '2023-03-25',
      'price': '50',
      'location': 'New York',
      'type': 'Competition',
    },
    {
      'title': 'Yoga Retreat',
      'date': '2023-04-10',
      'price': '30',
      'location': 'Los Angeles',
      'type': 'Workshop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredEvents = events.where((event) {
      DateTime eventDate = DateTime.parse(event['date']!);
      return (selectedEventType == null || event['type'] == selectedEventType) &&
          (double.parse(event['price']!) >= priceRange.start &&
              double.parse(event['price']!) <= priceRange.end) &&
          (selectedLocation == null || event['location'] == selectedLocation) &&
          (selectedDateRange == null ||
              (eventDate.isAfter(selectedDateRange!.start) &&
                  eventDate.isBefore(selectedDateRange!.end)));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: const Text('Filters'),
              children: [
                DropdownButtonFormField<String>(
                  value: selectedEventType,
                  onChanged: (value) {
                    setState(() {
                      selectedEventType = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Event Type'),
                  items: ['Competition', 'Workshop', 'Seminar']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price Range: \$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}'),
                    RangeSlider(
                      values: priceRange,
                      min: 0,
                      max: 200,
                      divisions: 10,
                      onChanged: (values) {
                        setState(() {
                          priceRange = values;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2024),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDateRange = picked;
                      });
                    }
                  },
                  child: const Text('Select Date Range'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Location'),
                  items: ['New York', 'Los Angeles']
                      .map((loc) => DropdownMenuItem(
                            value: loc,
                            child: Text(loc),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(event['title']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${event['date']}'),
                        Text('Location: ${event['location']}'),
                        Text('Price: \$${event['price']}'),
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
