import 'package:flutter/material.dart';

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

class ChatConversation {
  final String id;
  final String name;
  final String lastMessage;
  final String avatarUrl; // Using initials for this example
  final String time;
  final int unreadCount;

  ChatConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.avatarUrl,
    required this.time,
    this.unreadCount = 0,
  });
}

class UserNote {
  final String id;
  final String name;
  final String noteText;
  final String avatarUrl;
  final bool isMe;

  UserNote({
    required this.id,
    required this.name,
    required this.noteText,
    required this.avatarUrl,
    this.isMe = false,
  });
}