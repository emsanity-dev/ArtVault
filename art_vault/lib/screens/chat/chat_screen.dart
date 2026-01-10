import 'package:flutter/material.dart';
import '../screen_renderer.dart';
import '../home/components/custom_app_bar.dart';

class ChatScreen extends ScreenRenderer {
  const ChatScreen({super.key}) : super(title: 'Chat');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text('Chat Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
