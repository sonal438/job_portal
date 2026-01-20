import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobSeekerService {
  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> saveJobSeekerProfile({
    required String name,
    required String email,
    required String phone,
    required String skills,
  }) async {
    await _db.collection("jobseeker_profiles").doc(uid).set({
      "name": name,
      "email": email,
      "phone": phone,
      "skills": skills,
      "createdAt": Timestamp.now(),
    });

    await _db.collection("users").doc(uid).update({"profileCompleted": true});
  }
}
