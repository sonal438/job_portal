import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobService {
  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> postJob({
    required String title,
    required String category,
    required String location,
    required String employmentType,
    required String salary,
    required String description,
  }) async {
    await _db.collection("jobs").add({
      "employerId": uid,
      "title": title,
      "category": category,
      "location": location,
      "employmentType": employmentType,
      "salary": salary,
      "description": description,
      "createdAt": Timestamp.now(),
    });
  }
}
