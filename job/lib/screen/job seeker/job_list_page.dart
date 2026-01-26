import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'job_detail_page.dart';

class JobListPage extends StatelessWidget {
  final String category;

  const JobListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category Jobs'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: category == "All"
              ? FirebaseFirestore.instance.collection("jobs").snapshots()
              : FirebaseFirestore.instance
                    .collection("jobs")
                    .where("category", isEqualTo: category)
                    .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No jobs found"));
            }

            var jobs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                var job = jobs[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(job["title"]),
                    subtitle: Text(
                      '${job["location"]} • ${job["employmentType"]}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetailPage(
                            jobId: job.id, // ✅ document id
                            jobTitle: job["title"],
                            location: job["location"],
                            jobType: job["employmentType"],
                            salary: job["salary"],
                            description: job["description"],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
