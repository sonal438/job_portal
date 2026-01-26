import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/job_model.dart';

class JobService {
  final _jobs = FirebaseFirestore.instance.collection('jobs');
  final _categories = FirebaseFirestore.instance.collection('categories');

  Future<void> addJob(JobModel job) async {
    await _jobs.add(job.toMap());
  }

  Stream<List<JobModel>> getJobs() {
    return _jobs.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return JobModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<List<String>> getCategories() async {
    try {
      final snapshot = await _categories.get();
      return snapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  Future<void> postJob({
    required String title,
    required String category,
    required String location,
    required String employmentType,
    required String salary,
    required String description,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      await _jobs.add({
        'title': title,
        'category': category,
        'location': location,
        'employmentType': employmentType,
        'salary': salary,
        'description': description,
        'employerId': user.uid,
        'company': user.displayName ?? 'Unknown Company',
        'createdAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error posting job: $e');
      rethrow;
    }
  }
}
