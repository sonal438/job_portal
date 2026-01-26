import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_model.dart';

class ChatService {
  final _chats = FirebaseFirestore.instance.collection('chats');

  Future<void> sendMessage(ChatMessage msg) async {
    await _chats
        .doc(_chatId(msg.senderId, msg.receiverId))
        .collection('messages')
        .add(msg.toMap());
  }

  Stream<List<ChatMessage>> getMessages(String user1, String user2) {
    return _chats
        .doc(_chatId(user1, user2))
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatMessage.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  String _chatId(String a, String b) {
    return a.hashCode <= b.hashCode ? '$a-$b' : '$b-$a';
  }
}
