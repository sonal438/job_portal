import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/application_model.dart';

class ApplicationService {
  final _applications = FirebaseFirestore.instance.collection('applications');

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

  Future<void> applyJob({required String jobId}) async {}
}
