import 'package:flutter/material.dart';
import 'employer_register_page.dart';
import 'create_account_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String selectedRole = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // TITLE
              const Center(
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Select role:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 20),

              // JOB SEEKER CARD
              roleCard(
                title: "Job seeker",
                icon: Icons.folder,
                isSelected: selectedRole == "jobseeker",
                onTap: () {
                  setState(() {
                    selectedRole = "jobseeker";
                  });
                },
              ),

              const SizedBox(height: 15),

              // EMPLOYER CARD
              roleCard(
                title: "Employer",
                icon: Icons.person,
                isSelected: selectedRole == "employer",
                onTap: () {
                  setState(() {
                    selectedRole = "employer";
                  });
                },
              ),

              const Spacer(),

              // SELECT BUTTON
              Center(
                child: ElevatedButton(
                  onPressed: selectedRole.isEmpty
                      ? null
                      : () {
                          if (selectedRole == "jobseeker") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CreateAccountPage(role: "jobseeker"),
                              ),
                            );
                          } else if (selectedRole == "employer") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployerRegisterPage(),
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7BAEC7),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Selected",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ROLE CARD WIDGET
  Widget roleCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.diamond, size: 14),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(icon, size: 28),
          ],
        ),
      ),
    );
  }
}
