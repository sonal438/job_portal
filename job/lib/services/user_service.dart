import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  // Employer Profile
  Future<void> saveEmployerProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    await _db.collection("employer_profiles").doc(uid).set({
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
    });

    await _db.collection("users").doc(uid).update({"profileCompleted": true});
  }
}
