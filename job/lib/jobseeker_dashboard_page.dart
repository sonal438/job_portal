import 'package:flutter/material.dart';
import 'job_list_page.dart';
import 'chat_page.dart';
import 'applied_jobs_page.dart';

class JobseekerDashboard extends StatelessWidget {
  const JobseekerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB7CFEA),
        title: const Text(
          "Jobseeker Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            DashboardItem(
              icon: Icons.chat_bubble_outline,
              label: "Chat",
              iconColor: Colors.grey,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatTabScreen()),
                );
              },
            ),
            DashboardItem(
              icon: Icons.remove_red_eye_outlined,
              label: "View Posted Jobs",
              iconColor: Colors.black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const JobListPage(category: "All"),
                  ),
                );
              },
            ),
            DashboardItem(
              icon: Icons.description_outlined,
              label: "Lists",
              iconColor: Colors.black,
              onTap: () {
                // you can add another screen later
              },
            ),
            DashboardItem(
              icon: Icons.manage_search_outlined,
              label: "View Applied Jobs",
              iconColor: Colors.redAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatTabScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen {
  const ChatScreen();
}

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const DashboardItem({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // <-- clickable
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEAF3FF),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: iconColor),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
