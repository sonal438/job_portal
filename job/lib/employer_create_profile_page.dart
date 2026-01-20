import 'package:flutter/material.dart';
import 'package:job/employer_dashboard_page.dart';
import 'package:job/services/user_service.dart';

class EmployerCreateProfilePage extends StatefulWidget {
  const EmployerCreateProfilePage({super.key});

  @override
  State<EmployerCreateProfilePage> createState() =>
      _EmployerCreateProfilePageState();
}

class _EmployerCreateProfilePageState extends State<EmployerCreateProfilePage> {
  // 🔹 Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB7CFEA),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Create Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),

            // PROFILE IMAGE
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            const Text("Upload Photo", style: TextStyle(fontSize: 14)),

            const SizedBox(height: 25),

            inputField("Full Name", nameController),
            inputField("Email", emailController),
            inputField("Phone number", phoneController),
            inputField("Address", addressController),

            const SizedBox(height: 30),

            // ✅ SAVE PROFILE BUTTON (FIREBASE CONNECTED)
            SizedBox(
              width: 240,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  await UserService().saveEmployerProfile(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneController.text.trim(),
                    address: addressController.text.trim(),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EmployerDashboardPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7CFEA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Save profile",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // INPUT FIELD WIDGET
  Widget inputField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
      child: TextField(
        controller: controller,
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
