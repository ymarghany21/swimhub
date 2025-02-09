import 'package:flutter/material.dart';
import '../auth/forgot_password_code_screen.dart'; // Ensure this import path is correct

class ForgotPasswordEmailScreen extends StatelessWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 79, 165, 245), // Background color
      body: Center(
        child: Container(
          width: 350, // Adjust width to make the card centered
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(31, 0, 0, 0), // Light shadow
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              const Text(
                "RESET YOUR PASSWORD",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 79, 165, 245),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Email Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: const Color.fromARGB(
                      255, 240, 240, 240), // Light gray background
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                        color: Colors.transparent), // Transparent border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(
                          255, 79, 165, 245), // Blue border on focus
                      width: 2.0,
                    ),
                  ),
                  labelStyle: const TextStyle(color: Colors.grey), // Default color
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromARGB(
                        255, 79, 165, 245), // Label color on focus
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // No border
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // Send Reset Code Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to ForgotPasswordCodeScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordCodeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 79, 165, 245), // Match the background color
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'SEND RESET CODE',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Make the text white
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Go Back Link
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Go Back",
                  style: TextStyle(
                    color: Color.fromARGB(255, 79, 165, 245),
                  
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
