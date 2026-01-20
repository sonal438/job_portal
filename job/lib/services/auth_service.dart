import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // REGISTER
  Future<void> register({
    required String email,
    required String password,
    required String role,
  }) async {
    UserCredential user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _db.collection("users").doc(user.user!.uid).set({
      "email": email,
      "role": role,
      "profileCompleted": false,
      "createdAt": Timestamp.now(),
    });
  }

  // LOGIN
  Future<User?> login(String email, String password) async {
    UserCredential user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user;
  }
}
