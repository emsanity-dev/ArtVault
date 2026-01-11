import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ChatDetailScreen(
        userName: "Sarah Jenkins",
        userHandle: "@sarah_j_design",
        profileImageUrl:
            "https://i.pravatar.cc/300?img=5", // Random placeholder image
      ),
    );
  }
}

// --- MODEL CLASS ---
class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}

// --- SCREEN ---
class ChatDetailScreen extends StatefulWidget {
  final String userName;
  final String userHandle;
  final String profileImageUrl;

  const ChatDetailScreen({
    super.key,
    required this.userName,
    required this.userHandle,
    required this.profileImageUrl,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Initial dummy messages
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "See you then!",
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
    ChatMessage(
      text: "Great, I'll send over the files shortly.",
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    ChatMessage(
      text: "Hello! How can I help you today?",
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    _textController.clear();

    setState(() {
      // Insert new message at 0 (bottom of list because of reverse:true)
      _messages.insert(
        0,
        ChatMessage(text: text, isMe: true, timestamp: DateTime.now()),
      );

      // Auto-reply simulation
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                text: "Echo: $text",
                isMe: false,
                timestamp: DateTime.now(),
              ),
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. APP BAR WITH PROFILE INFO
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Return to chat list
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(widget.profileImageUrl),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.userHandle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () {},
          ),
        ],
      ),

      // 2. CHAT BODY
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              // IMPORTANT: Reverse ensures the list sticks to the bottom
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              // IMPORTANT: Add +1 to message count for the Profile Header
              itemCount: _messages.length + 1,
              itemBuilder: (context, index) {
                // Since the list is reversed:
                // index 0 = Bottom most message
                // index == length = Top most item (The Profile Header)

                if (index == _messages.length) {
                  return _buildInstagramStyleHeader();
                }

                // Normal message
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          const Divider(height: 1),
          _buildTextComposer(),
        ],
      ),
    );
  }

  // --- WIDGET: Top Profile Header (Instagram Style) ---
  Widget _buildInstagramStyleHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      alignment: Alignment.center,
      child: Column(
        children: [
          // Large Profile Picture
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(widget.profileImageUrl),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(height: 12),
          // Name
          Text(
            widget.userName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // Handle
          const SizedBox(height: 4),
          Text(
            widget.userHandle,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          // Subtitle
          const SizedBox(height: 4),
          Text(
            "You follow each other on Instagram",
            style: TextStyle(fontSize: 13, color: Colors.grey[400]),
          ),
          const SizedBox(height: 16),
          // View Profile Button
          InkWell(
            onTap: () {
              // Navigate to profile
              debugPrint("View Profile Tapped");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "View Profile",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // --- WIDGET: Message Bubble ---
  Widget _buildMessageBubble(ChatMessage message) {
    final isMe = message.isMe;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[600] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isMe
                ? const Radius.circular(20)
                : const Radius.circular(4),
            bottomRight: isMe
                ? const Radius.circular(4)
                : const Radius.circular(20),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  // --- WIDGET: Input Area ---
  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.blueAccent),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.gif_outlined, color: Colors.blueAccent),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.emoji_emotions_outlined,
                color: Colors.blueAccent,
              ),
              onPressed: () {},
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _textController,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: _handleSubmitted,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
                    hintText: "Message...",
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Send Button Logic: Only show if text is not empty?
            // For now, always show or show Mic icon if empty (like standard apps)
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blueAccent),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}
