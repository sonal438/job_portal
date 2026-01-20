import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApplicationService {
  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> applyJob({required String jobId}) async {
    await _db.collection("applications").add({
      "jobId": jobId,
      "jobseekerId": uid,
      "status": "applied",
      "appliedAt": Timestamp.now(),
    });
  }
}
