import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../gamification/presentation/providers/gamification_provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/profile_tile.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool isTyping = false;

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
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> sendMessage() async {
    final prompt = messageController.text.trim();

    if (prompt.isEmpty) return;

    messageController.clear();

    setState(() {
      messages.add({
        "message": prompt,
        "isUser": true,
      });
    });


    await ref.read(gamificationProvider).rewardForPrompt();

    try {
      final reply = await ref.read(chatProvider).sendMessage(prompt);
      await ref.read(gamificationProvider).rewardForResponse();

      if (!mounted) return;

      setState(() {
        messages.add({
          "message": reply,
          "isUser": false,
        });
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        messages.add({
          "message": "Sorry, something went wrong.",
          "isUser": false,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
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
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                itemCount:
                messages.length + (isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isTyping &&
                      index == messages.length) {
                    return const ChatBubble(
                      message: "Typing...",
                      isUser: false,
                    );
                  }

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