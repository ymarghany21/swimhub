import 'package:flutter/material.dart';
import '../Marketplace/Used_section/used_section.dart';
import '../Marketplace/Online_store_section/online_store_section.dart';
import '../Marketplace/Store_section/store_section.dart';

class MarketplaceScreen extends StatefulWidget {
  final String userRole; // To determine role-specific features

  const MarketplaceScreen({super.key, required this.userRole});

  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
      UsedSection(userRole: widget.userRole),
      OnlineStoreSection(userRole: widget.userRole),
      StoreSection(userRole: widget.userRole),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        centerTitle: true,
      ),
      body: sections[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Used'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Online Store'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Store'),
        ],
      ),
    );
  }
}
