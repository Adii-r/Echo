import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/profile_tile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      "message": "Hello! 👋",
      "isUser": false,
    },
    {
      "message":
      "I'm Echo. Ask me anything and I'll do my best to help you.",
      "isUser": false,
    },
  ];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "message": messageController.text.trim(),
        "isUser": true,
      });
    });

    messageController.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "ECHO",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w900,
            fontSize: 26,
            letterSpacing: 8,
            color: Colors.white,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? Center(
                child: Text(
                  "Start a conversation with Echo",
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  return ChatBubble(
                    message: message["message"],
                    isUser: message["isUser"],
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ProfileTile(),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                12,
                20,
                20,
              ),
              child: ChatInput(
                controller: messageController,
                onSend: sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}