// lib/users/coaches/home_page.dart
import 'package:flutter/material.dart';
import '../../profile/profile_page.dart';
import '../../shared/events/events_screen.dart';
import '../../shared/community/community_screen.dart';
import '../../shared/marketplace/marketplace_screen.dart';

class CoachHomePage extends StatelessWidget {
  final String userRole = 'Coach';

  const CoachHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: const Center(child: Text('Welcome to the Coach Dashboard')),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Marketplace'),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(fullName: 'John Doe', email: 'john.doe@example.com', role: userRole)));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => EventsScreen()));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityScreen()));
              break;
            case 4:
              Navigator.push(context, MaterialPageRoute(builder: (context) => MarketplaceScreen(userRole: userRole)));
              break;
          }
        },
      ),
    );
  }
}
  const String userRole = 'Coach';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coach Home")),
      body: const Center(child: Text("Welcome to the Coach Dashboard")),
    );
  }
