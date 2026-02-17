import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatelessWidget {
  final String userId;
  const UserProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applicant Profile')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Profile not found'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    child: Text(
                      (data['name'] ?? 'U')
                          .toString()
                          .split(' ')
                          .map((s) => s.isNotEmpty ? s[0] : '')
                          .take(2)
                          .join(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    data['name'] ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Email: ${data['email'] ?? ''}'),
                const SizedBox(height: 8),
                Text('Phone: ${data['phone'] ?? ''}'),
                const SizedBox(height: 8),
                Text('Address: ${data['address'] ?? ''}'),
                const SizedBox(height: 8),
                Text('Skills: ${data['skills'] ?? ''}'),
                const SizedBox(height: 8),
                Text('Education: ${data['education'] ?? ''}'),
                const SizedBox(height: 16),
                const Text(
                  'Other information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(data['bio'] ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
}
