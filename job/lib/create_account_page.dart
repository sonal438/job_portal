import 'package:flutter/material.dart';
import 'create_profile_page.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key, required String role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: const Color(0xFFB7CFEA),

              child: const Center(
                child: Text(
                  "Jobseeker",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // CREATE ACCOUNT TITLE
            const Text(
              "Create Account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // EMAIL FIELD
            inputField(hint: "Email"),

            const SizedBox(height: 15),

            // PASSWORD FIELD
            inputField(hint: "Password"),

            const SizedBox(height: 15),

            // CONFIRM PASSWORD FIELD
            inputField(hint: "Confirm Password"),

            const SizedBox(height: 30),

            // REGISTER BUTTON
            SizedBox(
              width: 180,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateProfilePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // INPUT FIELD WIDGET
  Widget inputField({required String hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        obscureText: hint.contains("Password"),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade300,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
