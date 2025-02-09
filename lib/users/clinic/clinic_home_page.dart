import 'package:flutter/material.dart';
import '../../profile/profile_page.dart';
import '../clinic/clinic_service_page.dart';
import '../clinic/clinic_bookings_screen.dart';
import '../clinic/clinic_register_branch.dart';

class ClinicHomePage extends StatefulWidget {
  const ClinicHomePage({super.key});

  @override
  _ClinicHomePageState createState() => _ClinicHomePageState();
}

class _ClinicHomePageState extends State<ClinicHomePage>
    with TickerProviderStateMixin {
  final String userRole = 'Clinic';
  AnimationController? animationController;
  bool multiple = true;

  List<Map<String, dynamic>> homeItems = [];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    homeItems = [
      {
        'title': 'My Services',
        'icon': Icons.design_services,
        'screen': MyServicesScreen(role: 'Clinic')
      },
      {
        'title': 'Bookings',
        'icon': Icons.calendar_today,
        'screen': BookingsScreen()
      },
      {
        'title': 'Register Clinic',
        'icon': Icons.add_business,
        'screen': RegisterBranchScreen(role: 'Clinic')
      },
    ];

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinic Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: multiple ? 2 : 1,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 1.3,
                ),
                itemCount: homeItems.length,
                itemBuilder: (context, index) {
                  final item = homeItems[index];
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / homeItems.length) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();

                  return AnimatedItem(
                    animation: animation,
                    animationController: animationController,
                    icon: item['icon'],
                    title: item['title'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item['screen']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedItem extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController? animationController;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AnimatedItem({
    super.key,
    required this.animation,
    required this.animationController,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: GestureDetector(
              onTap: onTap,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 50, color: Colors.blue),
                    const SizedBox(height: 10),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
