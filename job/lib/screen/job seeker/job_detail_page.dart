import 'package:flutter/material.dart';
import '../../../services/application_service.dart'; // <-- Import

class JobDetailPage extends StatefulWidget {
  final String jobId;
  final String jobTitle;
  final String location;
  final String jobType;
  final String salary;
  final String description;

  const JobDetailPage({
    super.key,
    required this.jobId,
    required this.jobTitle,
    required this.location,
    required this.jobType,
    required this.salary,
    required this.description,
  });

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
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
              widget.jobTitle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              '${widget.location} • ${widget.jobType}',
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 8),

            Text(
              'Salary: ${widget.salary}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            const Text(
              'Job Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(widget.description),

            const Spacer(),

            // APPLY BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await ApplicationService().applyJob(jobId: widget.jobId);

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Applied Successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString().replaceAll('Exception: ', ''),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text('Apply Job'),
              ),
            ),

            const SizedBox(height: 10),

            // UPLOAD CV BUTTON (optional)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // You can add upload CV logic later
                },
                child: const Text('Upload CV'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
