import 'package:flutter/material.dart';
import 'auth/welcome_page.dart'; // Import the WelcomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 183, 177, 58),
        ),
        useMaterial3: true,
      ),
      home: const WelcomePage(), // Set WelcomePage as the first screen
    );
  }
}
