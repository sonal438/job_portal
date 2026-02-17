import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    await _firestore.collection('chats').add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'time': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getMessages(String user1, String user2) {
    return _firestore
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }
}
