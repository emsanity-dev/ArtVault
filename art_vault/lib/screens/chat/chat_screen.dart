import 'package:flutter/material.dart';
import '../screen_renderer.dart';
import 'screens/chat_list_screen.dart';

class ChatScreen extends ScreenRenderer {
  const ChatScreen({super.key}) : super(title: 'Chat');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 1. Removes the default back button
        elevation: 1,
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            // 2. Profile Avatar (Kept as a header icon)
            const CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"),
              radius: 18,
            ),
            const SizedBox(width: 12),

            // 3. Simple Title (No "Online" status)
            const Text(
              "Messages",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          // 4. Settings Button (Replaced Options/Call buttons)
          IconButton(
            onPressed: () {
              // Handle settings tap
            },
            icon: const Icon(Icons.settings, color: Colors.black54),
          ),
          const SizedBox(width: 8), // Small padding for right alignment
        ],
      ),
      body: const ChatListScreen(),
    );
  }
}
