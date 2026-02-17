import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'job_detail_page.dart';

class JobListPage extends StatelessWidget {
  final String category;
  final String? searchQuery;

  const JobListPage({super.key, required this.category, this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Jobs'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final TextEditingController searchController =
                  TextEditingController();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Search Jobs'),
                    content: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Type keyword...',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          final q = searchController.text.trim();
                          Navigator.pop(context);
                          if (q.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobListPage(
                                  category: category,
                                  searchQuery: q,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("jobs").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No jobs found"));
            }

            var jobs = snapshot.data!.docs;

            // If a category filter is provided (and not "All"), filter by category.
            if (category != "All") {
              jobs = jobs
                  .where(
                    (d) =>
                        (d.data() as Map<String, dynamic>)["category"] ==
                        category,
                  )
                  .toList();
            }

            // If a search query is provided, filter by title, description or category (case-insensitive).
            if (searchQuery != null && searchQuery!.trim().isNotEmpty) {
              final q = searchQuery!.toLowerCase();
              jobs = jobs.where((d) {
                final data = d.data() as Map<String, dynamic>;
                final title = (data["title"] ?? "").toString().toLowerCase();
                final description = (data["description"] ?? "")
                    .toString()
                    .toLowerCase();
                final cat = (data["category"] ?? "").toString().toLowerCase();
                return title.contains(q) ||
                    description.contains(q) ||
                    cat.contains(q);
              }).toList();
            }

            // If after filtering there are no jobs, show a friendly message.
            if (jobs.isEmpty) {
              if (searchQuery != null && searchQuery!.trim().isNotEmpty) {
                return Center(
                  child: Text('No results found for "${searchQuery!}"'),
                );
              }
              return const Center(child: Text('No jobs found'));
            }

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
