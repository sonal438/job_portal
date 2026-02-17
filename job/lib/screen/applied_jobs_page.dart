import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job/models/application_model.dart';
import 'package:job/models/job_model.dart';
import 'package:job/screen/job_details_page.dart';
import 'package:job/services/application_service.dart';
import 'package:job/services/job_service.dart';

class AppliedJobsPage extends StatefulWidget {
  final String userId; // store the userId from ViewApplicantsPage
  const AppliedJobsPage({super.key, required this.userId});

  @override
  State<AppliedJobsPage> createState() => _AppliedJobsPageState();
}

class _AppliedJobsPageState extends State<AppliedJobsPage> {
  final ApplicationService _applicationService = ApplicationService();
  final JobService _jobService = JobService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final userId = widget.userId; // <-- use passed userId

    return Scaffold(
      appBar: AppBar(
        title: const Text("Applied Jobs"),
        backgroundColor: const Color(0xFFB7CFEA),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ApplicationModel>>(
        stream: _applicationService.getMyApplications(userId),
        builder: (context, applicationSnapshot) {
          if (applicationSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (applicationSnapshot.hasError) {
            return Center(child: Text("Error: ${applicationSnapshot.error}"));
          }

          final applications = applicationSnapshot.data ?? [];

          if (applications.isEmpty) {
            return const Center(
              child: Text(
                "This user has not applied for any jobs",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application = applications[index];
              return FutureBuilder<DocumentSnapshot>(
                future: _firestore
                    .collection('jobs')
                    .doc(application.jobId)
                    .get(),
                builder: (context, jobSnapshot) {
                  if (jobSnapshot.connectionState == ConnectionState.waiting) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (!jobSnapshot.hasData || !jobSnapshot.data!.exists) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: const ListTile(title: Text("Job not found")),
                    );
                  }

                  final jobData =
                      jobSnapshot.data!.data() as Map<String, dynamic>;
                  final job = JobModel.fromMap(jobData, application.jobId);

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailsPage(job: job),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7F0FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.work_outline,
                            color: Colors.blueGrey,
                          ),
                          title: Text(
                            job.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${job.company}\n${job.location}"),
                              const SizedBox(height: 4),
                              Chip(
                                label: Text(
                                  _getStatusLabel(application.status),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: _getStatusColor(
                                  application.status,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      ),
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

  String _getStatusLabel(String status) {
    switch (status) {
      case 'applied':
        return 'Applied';
      case 'reviewed':
        return 'Under Review';
      case 'accepted':
        return 'Accepted';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Pending';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'applied':
        return Colors.blue;
      case 'reviewed':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
