import 'package:flutter/material.dart';
import '../create_profile_page.dart';
import '../../../services/auth_service.dart'; // <-- Import AuthService

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key, required this.role});

  final String role;

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  // ✅ Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

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
              child: Center(
                child: Text(
                  widget.role == "employer" ? "Employer" : "Jobseeker",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
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
            inputField(hint: "Email", controller: emailController),

            const SizedBox(height: 15),

            // PASSWORD FIELD
            inputField(hint: "Password", controller: passwordController),

            const SizedBox(height: 15),

            // CONFIRM PASSWORD FIELD
            inputField(hint: "Confirm Password", controller: confirmController),

            const SizedBox(height: 30),

            // REGISTER BUTTON
            SizedBox(
              width: 180,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  // ✅ Validation
                  if (passwordController.text != confirmController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Passwords do not match")),
                    );
                    return;
                  }

                  // ✅ Backend Register
                  await AuthService().register(
                    email: emailController.text,
                    password: passwordController.text,
                    role: "jobseeker",
                    name: '', // IMPORTANT
                  );

                  // ✅ Redirect
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
  Widget inputField({
    required String hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller,
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
