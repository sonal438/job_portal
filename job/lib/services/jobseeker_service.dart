import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/application_model.dart';

class JobseekerService {
  final _applications = FirebaseFirestore.instance.collection('applications');

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
}
