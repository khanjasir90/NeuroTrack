import 'package:flutter/material.dart';
import 'package:patient/presentation/auth/personal_details_screen.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 20), // Add horizontal padding
      child: SizedBox(
        width: double.infinity, // Makes the button expand to full width
        height: 50, // Adjusted height for better appearance
        child: ElevatedButton(
          onPressed: () {

            Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PersonalDetailsScreen()),
        );
           
            // Implement Google Sign-in logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 2, // Small shadow effect
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Prevent unnecessary stretching
            mainAxisAlignment: MainAxisAlignment.center, // Center elements
            children: [
              Image.asset(
                'assets/google_logo.png', // Ensure the correct path
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 10), // Space between icon and text
              const Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}