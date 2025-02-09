import 'package:flutter/material.dart';

class UsedSection extends StatefulWidget {
  final String userRole;

  const UsedSection({super.key, required this.userRole});

  @override
  _UsedSectionState createState() => _UsedSectionState();
}

class _UsedSectionState extends State<UsedSection> {
  String? selectedItemType;
  RangeValues priceRange = const RangeValues(0, 500);
  String? selectedLocation;
  String? selectedCondition;

  List<Map<String, String>> items = [
    {
      'name': 'Swimming Goggles',
      'itemType': 'Accessories',
      'price': '50',
      'location': 'New York',
      'condition': 'New',
    },
    {
      'name': 'Swim Suit',
      'itemType': 'Clothing',
      'price': '30',
      'location': 'Los Angeles',
      'condition': 'Used',
    },
  ];

  List<Map<String, String>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    applyFilters(); // Initialize with all items visible
  }

  void applyFilters() {
    setState(() {
      filteredItems = items.where((item) {
        return (selectedItemType == null ||
                item['itemType'] == selectedItemType) &&
            (double.parse(item['price']!) >= priceRange.start &&
                double.parse(item['price']!) <= priceRange.end) &&
            (selectedLocation == null ||
                item['location'] == selectedLocation) &&
            (selectedCondition == null ||
                item['condition'] == selectedCondition);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Used Marketplace'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: StatefulBuilder(
              builder: (context, setState) {
                return ExpansionTile(
                  title: const Text('Filters'),
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedItemType,
                      onChanged: (value) {
                        setState(() {
                          selectedItemType = value;
                        });
                        applyFilters();
                      },
                      decoration: const InputDecoration(labelText: 'Item Type'),
                      items: ['Accessories', 'Clothing', 'Equipment']
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price Range: \$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        RangeSlider(
                          values: priceRange,
                          min: 0,
                          max: 500,
                          divisions: 10,
                          onChanged: (values) {
                            setState(() {
                              priceRange = values;
                            });
                            applyFilters();
                          },
                        ),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedLocation,
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value;
                        });
                        applyFilters();
                      },
                      decoration: const InputDecoration(labelText: 'Location'),
                      items: ['New York', 'Los Angeles']
                          .map((loc) => DropdownMenuItem(
                                value: loc,
                                child: Text(loc),
                              ))
                          .toList(),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCondition,
                      onChanged: (value) {
                        setState(() {
                          selectedCondition = value;
                        });
                        applyFilters();
                      },
                      decoration: const InputDecoration(labelText: 'Condition'),
                      items: ['New', 'Used']
                          .map((cond) => DropdownMenuItem(
                                value: cond,
                                child: Text(cond),
                              ))
                          .toList(),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      item['name']!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${item['itemType']}'),
                        Text('Price: \$${item['price']}'),
                        Text('Location: ${item['location']}'),
                        Text('Condition: ${item['condition']}'),
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
