import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'job seeker/post_job_screen.dart';
import 'job seeker/job_list_page.dart';
import 'chat_page.dart';
import 'view_applicants_page.dart'; // ← ADD THIS FILE

class EmployerDashboardPage extends StatelessWidget {
  const EmployerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

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
          children: [
            DashboardItem(
              icon: Icons.campaign,
              title: "Post Jobs",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PostJobScreen()),
                );
              },
            ),

            DashboardItem(
              icon: Icons.visibility,
              title: "View Posted Jobs",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const JobListPage(category: "All"),
                  ),
                );
              },
            ),

            // VIEW APPLICANTS CONNECTED HERE
            DashboardItem(
              icon: Icons.person_search,
              title: "View Applicants",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ViewApplicantsPage(employerId: currentUser!.uid),
                  ),
                );
              },
            ),

            // CHAT CONNECTED HERE
            DashboardItem(
              icon: Icons.chat_bubble_outline,
              title: "Chat",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      senderId: currentUser!.uid,
                      receiverId: "jobseeker_id_here",
                      receiverName: '',
                      // later replace with selected applicant id
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DashboardItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
