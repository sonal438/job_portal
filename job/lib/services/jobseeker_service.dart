import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/application_model.dart';

class JobseekerService {
  final _applications = FirebaseFirestore.instance.collection('applications');
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> applyForJob({
    required String jobId,
    required String jobseekerId,
  }) async {
    await _applications.add({
      'jobId': jobId,
      'jobseekerId': jobseekerId,
      'status': 'applied',
    });
  }

  Stream<List<ApplicationModel>> myApplications(String userId) {
    return _applications
        .where('jobseekerId', isEqualTo: userId)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => ApplicationModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> saveJobSeekerProfile({
    required String name,
    required String email,
    required String phone,
    String? address,
    String? skills,
    String? education,
    String? bio,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not logged in');

    final data = {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address ?? '',
      'skills': skills ?? '',
      'education': education ?? '',
      'bio': bio ?? '',
      'profileCompleted': true,
    };

    await _users.doc(user.uid).set(data, SetOptions(merge: true));
  }
}
