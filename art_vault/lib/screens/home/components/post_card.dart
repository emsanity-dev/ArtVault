import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final int index;

  const PostCard({super.key, required this.index});

  @override
  PostCardState createState() => PostCardState();
}

class PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      // Adding clip behavior ensures children (like images) don't spill out of rounded corners
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    'User${widget.index + 1}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@artistname${widget.index}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      Text(
                        '2 hours ago',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Artwork image placeholder
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              // This setup is ready for when you add a real image:
              // image: DecorationImage(image: NetworkImage('...'), fit: BoxFit.cover),
            ),
            child: Icon(Icons.art_track, size: 80, color: Colors.grey[400]),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          children: [
                            AppBar(
                              title: Text('Comments'),
                              leading: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              elevation: 0,
                            ),
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.grey,
                                    ),
                                    title: Text('User1'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Great art!'),
                                        Row(
                                          children: [
                                            Text(
                                              '2h',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Like',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Reply',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.grey,
                                    ),
                                    title: Text('User2'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Love the colors.'),
                                        Row(
                                          children: [
                                            Text(
                                              '1h',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Like',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Reply',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IntrinsicHeight(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.grey,
                                    ),
                                    SizedBox(width: 8),
                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.add),
                                      onSelected: (value) {},
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'image',
                                          child: Text('Image'),
                                        ),
                                        PopupMenuItem(
                                          value: 'gif',
                                          child: Text('GIF'),
                                        ),
                                        PopupMenuItem(
                                          value: 'sticker',
                                          child: Text('Sticker'),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: TextField(
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          hintText: 'Add a comment...',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Likes count
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '128 likes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Exploring the beauty of abstract art through colors and shapes. #art #abstract #creative',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
