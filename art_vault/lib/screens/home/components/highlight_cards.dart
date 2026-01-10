import 'package:flutter/material.dart';

/// Stateless widget for displaying highlight cards
/// These cards show featured art highlights in a horizontal scrollable list
class HighlightCards extends StatefulWidget {
  const HighlightCards({super.key});

  @override
  State<HighlightCards> createState() => _HighlightCardsState();
}

class _HighlightCardsState extends State<HighlightCards> {
  // Sample art data for the highlight cards
  final List<Map<String, dynamic>> _highlightArts = [
    {
      "id": 1,
      "title": "Abstract Art",
      "artist": "Modern Artist",
      "category": "Digital",
      "image": "https://picsum.photos/800/600?random=1",
      "username": "@modern_artist",
      "timePosted": "2 hours ago",
      "likes": 1250,
      "comments": 48,
    },
    {
      "id": 2,
      "title": "Mountain View",
      "artist": "Landscape Master",
      "category": "Nature",
      "image": "https://picsum.photos/800/600?random=2",
      "username": "@nature_lover",
      "timePosted": "1 day ago",
      "likes": 890,
      "comments": 35,
    },
    {
      "id": 3,
      "title": "Modern Sculpture",
      "artist": "3D Creator",
      "category": "Contemporary",
      "image": "https://picsum.photos/800/600?random=3",
      "username": "@3d_artist",
      "timePosted": "3 days ago",
      "likes": 1520,
      "comments": 67,
    },
  ];

  void _showArtDetailsModal(BuildContext context, Map<String, dynamic> art) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ArtDetailsModal(art: art),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Art Highlights',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: _highlightArts.map((art) {
              return GestureDetector(
                onTap: () {
                  _showArtDetailsModal(context, art);
                },
                child: _buildHighlightCard(art['image']),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// Helper method to create individual highlight cards
  Widget _buildHighlightCard(String imageUrl) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4.0, spreadRadius: 0.5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          height: 140,
          width: 140,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.image, size: 40, color: Colors.grey),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ArtDetailsModal extends StatelessWidget {
  final Map<String, dynamic> art;

  const _ArtDetailsModal({required this.art});

  @override
  Widget build(BuildContext context) {
    final String title = art['title'] ?? 'Unknown';
    final String artist = art['artist'] ?? 'Unknown';
    final String username = art['username'] ?? '@unknown';
    final String timePosted = art['timePosted'] ?? 'Unknown time';
    final int likes = art['likes'] ?? 0;
    final int comments = art['comments'] ?? 0;
    final String imageUrl = art['image'] ?? '';

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image section - takes up most of the modal
          Stack(
            children: [
              // Full-width image that fills available space
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  image: imageUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey[200],
                ),
                child: imageUrl.isEmpty
                    ? const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      )
                    : null,
              ),
              // Close button positioned at top-right - minimal and unobtrusive
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 16,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
          // Details section - compact and informative
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Art title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Artist info and metadata in a row
                Row(
                  children: [
                    Text(
                      artist,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      username,
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '• $timePosted',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Likes and comments in a compact row
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.red, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '$likes',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 4),
                        const Text('likes'),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        const Icon(Icons.comment, color: Colors.blue, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '$comments',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 4),
                        const Text('comments'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
