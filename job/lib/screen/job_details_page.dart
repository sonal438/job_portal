import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/job_model.dart';

class JobDetailsPage extends StatelessWidget {
  final JobModel job;

  const JobDetailsPage({super.key, required this.job});

  // APPLY FUNCTION
  Future<void> applyJob(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await FirebaseFirestore.instance.collection("applications").add({
      "jobId": job.id,
      "jobTitle": job.title,
      "jobseekerId": user.uid,
      "employerId": job.employerId,
      "status": "applied",
      "appliedAt": Timestamp.now(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Applied Successfully")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        backgroundColor: const Color(0xFFB7CFEA),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              job.company,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.location_on, size: 18),
                const SizedBox(width: 6),
                Text(job.location),
                const SizedBox(width: 16),
                const Icon(Icons.work_outline, size: 18),
                const SizedBox(width: 6),
                Text(job.employmentType),
              ],
            ),

            const SizedBox(height: 12),

            Chip(
              label: Text(job.salary),
              backgroundColor: const Color(0xFFB7CFEA),
            ),

            const SizedBox(height: 16),

            const Text(
              'Job Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            Text(job.description),

            const SizedBox(height: 24),

            const Text(
              'Posted On',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            Text(job.createdAt.toLocal().toString()),

            const SizedBox(height: 30),

            // APPLY BUTTON ADDED HERE
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => applyJob(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7CFEA),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Apply Job", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
