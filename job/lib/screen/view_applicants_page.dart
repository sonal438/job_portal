import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_profile_page.dart';
import 'applied_jobs_page.dart';

class ViewApplicantsPage extends StatelessWidget {
  const ViewApplicantsPage({super.key, required this.employerId});
  final String employerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobseekers'),
        backgroundColor: const Color(0xFFB7CFEA),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('name')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final doc = users[index];
              final data = doc.data() as Map<String, dynamic>? ?? {};
              final name = (data['name'] ?? 'Unknown').toString();
              final email = (data['email'] ?? '').toString();
              final skills = (data['skills'] ?? '').toString();

              // Function to get initials for avatar
              String initials() {
                final parts = name.split(' ');
                final chars = parts.where((s) => s.isNotEmpty).map((s) => s[0]);
                return chars.take(2).join().toUpperCase();
              }

              return ListTile(
                leading: CircleAvatar(child: Text(initials())),
                title: Text(name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (email.isNotEmpty) Text(email),
                    if (skills.isNotEmpty) Text('Skills: $skills'),
                  ],
                ),
                isThreeLine: skills.isNotEmpty,

                // Trailing icon opens the user's applied jobs screen
                trailing: IconButton(
                  icon: const Icon(Icons.work),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AppliedJobsPage(userId: doc.id),
                      ),
                    );
                  },
                ),

                // Tapping the ListTile opens the user profile
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserProfilePage(userId: doc.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
