import 'package:flutter/material.dart';
import 'job_list_page.dart';
import 'category_list_screen.dart';
import '../chat_page.dart'; // import your chat screen
import '../applied_jobs_page.dart';
import '../user_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart'; // for current user id

class JobseekerDashboard extends StatelessWidget {
  const JobseekerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current logged-in jobseeker ID
    final currentUser = FirebaseAuth.instance.currentUser;

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
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              if (currentUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserProfilePage(userId: currentUser.uid),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please log in to view profile'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 5,
          children: [
            // CHAT BUTTON
            DashboardItem(
              icon: Icons.chat_bubble_outline,
              label: "Chat",
              iconColor: Colors.grey,
              onTap: () {
                if (currentUser != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        senderId: currentUser.uid,
                        receiverId: "employer_id_here",
                        receiverName: '', // replace with employer id
                      ),
                    ),
                  );
                }
              },
            ),

            // VIEW POSTED JOBS
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

            // CATEGORY LIST
            DashboardItem(
              icon: Icons.description_outlined,
              label: "Lists",
              iconColor: Colors.black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CategoryListScreen()),
                );
              },
            ),

            // VIEW APPLIED JOBS
            DashboardItem(
              icon: Icons.manage_search_outlined,
              label: "View Applied Jobs",
              iconColor: Colors.redAccent,
              onTap: () {
                if (currentUser != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AppliedJobsPage(userId: currentUser.uid),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please log in to view applied jobs'),
                    ),
                  );
                }
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: iconColor),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
