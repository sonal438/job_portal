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
        child: ListView(
          children: [
            jobCard(context, 'Teacher', 'Kathmandu', 'Full Time'),
            jobCard(context, 'Lecturer', 'Pokhara', 'Part Time'),
            jobCard(context, 'Instructor', 'Lalitpur', 'Contract'),
          ],
        ),
      ),
    );
  }

  Widget jobCard(
    BuildContext context,
    String title,
    String location,
    String type,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text('$location • $type'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailPage(
                jobTitle: title,
                location: location,
                jobType: type,
              ),
            ),
          );
        },
      ),
    );
  }
}
