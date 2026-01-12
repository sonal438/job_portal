import 'package:flutter/material.dart';
import 'post_job_screen.dart';
import 'chat_page.dart'; // <-- Import your chat screen

class EmployerDashboardPage extends StatelessWidget {
  const EmployerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB7CFEA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Employer Dashboard",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 4,
          children: const [
            DashboardItem(icon: Icons.campaign, title: "Post Jobs"),
            DashboardItem(icon: Icons.visibility, title: "View Posted Jobs"),
            DashboardItem(icon: Icons.person_search, title: "View Applicants"),
            DashboardItem(icon: Icons.chat_bubble_outline, title: "Chat"),
          ],
        ),
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const DashboardItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == "Post Jobs") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostJobScreen()),
          );
        } else if (title == "Chat") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatTabScreen()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE7F0FA),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
