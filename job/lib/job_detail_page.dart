import 'package:flutter/material.dart';

class JobDetailPage extends StatelessWidget {
  final String jobTitle;
  final String location;
  final String jobType;

  const JobDetailPage({
    super.key,
    required this.jobTitle,
    required this.location,
    required this.jobType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Details'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobTitle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              '$location • $jobType',
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 16),

            const Text(
              'Job Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'This is a sample job description. In future, this content will come from employer posted job data.',
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Apply Job'),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Upload CV'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
