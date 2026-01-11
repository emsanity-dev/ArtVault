import 'package:flutter/material.dart';
import '../models/chat_models.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  // Mock Data for Conversations
  static final List<ChatConversation> _conversations = [
    ChatConversation(
      id: '1',
      name: 'Alice Johnson',
      lastMessage: 'Hey, are we still on?',
      avatarUrl: 'A',
      time: '10:30 AM',
      unreadCount: 2,
    ),
    ChatConversation(
      id: '2',
      name: 'Bob Smith',
      lastMessage: 'Files sent.',
      avatarUrl: 'B',
      time: 'Yesterday',
      unreadCount: 0,
    ),
    ChatConversation(
      id: '3',
      name: 'Team Project',
      lastMessage: 'Sarah: Done.',
      avatarUrl: 'T',
      time: 'Mon',
      unreadCount: 5,
    ),
    ChatConversation(
      id: '4',
      name: 'David Lee',
      lastMessage: 'Call me back.',
      avatarUrl: 'D',
      time: 'Sun',
      unreadCount: 0,
    ),
    ChatConversation(
      id: '5',
      name: 'Emma Wilson',
      lastMessage: 'Great idea!',
      avatarUrl: 'E',
      time: 'Sun',
      unreadCount: 1,
    ),
    ChatConversation(
      id: '6',
      name: 'Frank Miller',
      lastMessage: 'See you there.',
      avatarUrl: 'F',
      time: 'Sat',
      unreadCount: 0,
    ),
  ];

  // Mock Data for Notes
  static final List<UserNote> _notes = [
    UserNote(
      id: '0',
      name: 'Your Note',
      noteText: 'Share a thought...',
      avatarUrl: 'Me',
      isMe: true,
    ),
    UserNote(
      id: '1',
      name: 'Alice',
      noteText: 'Craving pizza 🍕',
      avatarUrl: 'A',
    ),
    UserNote(id: '2', name: 'Bob', noteText: 'Gym time 💪', avatarUrl: 'B'),
    UserNote(
      id: '3',
      name: 'Sarah',
      noteText: 'Working late 😴',
      avatarUrl: 'S',
    ),
    UserNote(id: '4', name: 'Mike', noteText: 'On vacation!', avatarUrl: 'M'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Search Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // 2. Instagram Style Notes Section
        _buildInstagramNotesSection(context),

        const Divider(height: 1),

        // 3. List of Conversations
        Expanded(
          child: ListView.separated(
            itemCount: _conversations.length,
            separatorBuilder: (ctx, index) =>
                const Divider(height: 1, indent: 82), // Indent to match avatar
            itemBuilder: (context, index) {
              final chat = _conversations[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    chat.avatarUrl,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                title: Text(
                  chat.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  chat.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: chat.unreadCount > 0 ? Colors.black87 : Colors.grey,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      chat.time,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    if (chat.unreadCount > 0)
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          chat.unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetailScreen(
                        userName: "Jane Doe",
                        userHandle: "@janedoe_dev",
                        profileImageUrl:
                            "https://i.pravatar.cc/150?img=5", // Example URL
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // --- Helper Widget for Notes ---
  Widget _buildInstagramNotesSection(BuildContext context) {
    return SizedBox(
      // FIX: Increased height to 135 to prevent RenderFlex Overflow
      height: 135,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return Container(
            width: 80, // Fixed width for each item
            margin: const EdgeInsets.only(right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // The Note Bubble
                if (!note.isMe || note.noteText != 'Share a thought...')
                  Container(
                    height: 28, // Fixed height keeps alignment consistent
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      note.noteText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                    ),
                  )
                else
                  // Spacer to push "Me" avatar down if no note exists
                  const SizedBox(height: 32),

                // The Avatar
                Stack(
                  clipBehavior:
                      Clip.none, // Ensures the '+' badge isn't cut off
                  children: [
                    CircleAvatar(
                      radius: 30, // Large avatar for notes
                      backgroundColor: Colors.grey[200],
                      child: Text(
                        note.avatarUrl,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    if (note.isMe)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_circle,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 4),

                // The Name
                Text(
                  note.name,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
