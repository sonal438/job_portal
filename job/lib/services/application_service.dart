import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/application_model.dart';

class ApplicationService {
  final _applications = FirebaseFirestore.instance.collection('applications');
  final _auth = FirebaseAuth.instance;

  Future<void> apply(ApplicationModel app) async {
    await _applications.add(app.toMap());
  }

  Stream<List<ApplicationModel>> getMyApplications(String userId) {
    return _applications
        .where('jobseekerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ApplicationModel.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  Future<void> applyJob({required String jobId}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Check if already applied
      final existingApplication = await _applications
          .where('jobId', isEqualTo: jobId)
          .where('jobseekerId', isEqualTo: user.uid)
          .get();

      if (existingApplication.docs.isNotEmpty) {
        throw Exception('You have already applied for this job');
      }

      // Create new application
      final application = ApplicationModel(
        id: '',
        jobId: jobId,
        jobseekerId: user.uid,
        status: 'applied',
        appliedAt: DateTime.now(),
      );

      await apply(application);
    } catch (e) {
      print('Error applying for job: $e');
      rethrow;
    }
  }
}
