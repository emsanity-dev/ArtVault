// lib/chat/components/chat_app_bar.dart

import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String userAvatar; // Initials or URL
  final bool isOnline;
  final VoidCallback? onVideoCall;
  final VoidCallback? onAudioCall;

  const ChatAppBar({
    super.key,
    required this.userName,
    this.userAvatar = "A", // Default fallback
    this.isOnline = false,
    this.onVideoCall,
    this.onAudioCall,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0, // Reduces gap between back arrow and avatar
      title: Row(
        children: [
          // 1. User Avatar with Online Dot
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  userAvatar,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              if (isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          
          // 2. Name and Status Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  isOnline ? "Online" : "Last seen recently",
                  style: TextStyle(
                    color: isOnline ? Colors.green : Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // 3. Call Actions
        IconButton(
          icon: const Icon(Icons.videocam_outlined, color: Colors.blueAccent),
          onPressed: onVideoCall ?? () {},
        ),
        IconButton(
          icon: const Icon(Icons.call_outlined, color: Colors.blueAccent),
          onPressed: onAudioCall ?? () {},
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.black54),
          onSelected: (value) {
            // Handle menu selection
          },
          itemBuilder: (BuildContext context) {
            return {'View Contact', 'Search', 'Mute Notifications', 'Block'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}