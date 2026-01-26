import 'package:flutter/material.dart';

class ChatTabScreen extends StatefulWidget {
  const ChatTabScreen({super.key});

  @override
  State<ChatTabScreen> createState() => _ChatTabScreenState();
}

class _ChatTabScreenState extends State<ChatTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedUser = "Select a chat";

  final List<Map<String, String>> chatUsers = [
    {"name": "Alina Sharma", "last": "Teacher job"},
    {"name": "Rahul Khatri", "last": "Interview"},
    {"name": "Sunita Shrestha", "last": "Job inquiry"},
  ];

  final TextEditingController _messageController = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void openChat(String name) {
    setState(() {
      selectedUser = name;
    });
    _tabController.animateTo(1); // Switch to Messages tab
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add(_messageController.text);
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: const Color(0xFFB7CFEA),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Chats"),
            Tab(text: "Messages"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ---------------- CHAT LIST TAB ----------------
          ListView.builder(
            itemCount: chatUsers.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFB7CFEA),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(chatUsers[index]["name"]!),
                subtitle: Text(chatUsers[index]["last"]!),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => openChat(chatUsers[index]["name"]!),
              );
            },
          ),

          // ---------------- CHAT SCREEN TAB ----------------
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade200,
                child: Text(
                  selectedUser,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB7CFEA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(messages[index]),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: "Type message...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFFB7CFEA)),
                      onPressed: sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
