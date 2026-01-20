import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot> getMessages(String chatId) {
    return _db
        .collection("messages")
        .doc(chatId)
        .collection("chat")
        .orderBy("timestamp")
        .snapshots();
  }

  Future<void> sendMessage(String chatId, String text) async {
    await _db.collection("messages").doc(chatId).collection("chat").add({
      "senderId": uid,
      "text": text,
      "timestamp": Timestamp.now(),
    });
  }
}
