import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // --- 1. DATA SOURCES ---

  final List<String> _categories = [
    "All",
    "Classic",
    "Impressionist",
    "Modern",
    "Surrealism",
    "Portrait",
  ];
  String _selectedCategory = "All";

  final List<Map<String, dynamic>> _allArtists = [
    {
      "id": 1,
      "name": "Da Vinci",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Leonardo_da_Vinci_-_presumed_self-portrait_-_WGA12798.jpg/800px-Leonardo_da_Vinci_-_presumed_self-portrait_-_WGA12798.jpg",
    },
    {
      "id": 2,
      "name": "Van Gogh",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg/800px-Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg",
    },
    {
      "id": 3,
      "name": "Picasso",
      "image":
          "https://upload.wikimedia.org/wikipedia/en/thumb/5/5c/Pablo_Picasso%2C_1958_%28cropped%29.jpg/800px-Pablo_Picasso%2C_1958_%28cropped%29.jpg",
    },
    {
      "id": 4,
      "name": "Dali",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Salvador_Dal%C3%AD_1939.jpg/800px-Salvador_Dal%C3%AD_1939.jpg",
    },
    {
      "id": 5,
      "name": "Munch",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Edvard_Munch_1933.jpg/800px-Edvard_Munch_1933.jpg",
    },
  ];

  final List<Map<String, dynamic>> _allArts = [
    {
      "id": 1,
      "title": "Mona Lisa",
      "artist": "Da Vinci",
      "category": "Classic",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/800px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg",
      "username": "@leo_da_vinci",
      "timePosted": "2 hours ago",
      "likes": 1250,
      "comments": 48,
    },
    {
      "id": 2,
      "title": "Starry Night",
      "artist": "Van Gogh",
      "category": "Impressionist",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/800px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg",
      "username": "@vincent_vg",
      "timePosted": "5 hours ago",
      "likes": 2800,
      "comments": 112,
    },
    {
      "id": 3,
      "title": "The Scream",
      "artist": "Munch",
      "category": "Modern",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Edvard_Munch%2C_1893%2C_The_Scream%2C_oil%2C_tempera_and_pastel_on_cardboard%2C_91_x_73_cm%2C_National_Gallery_of_Norway.jpg/800px-Edvard_Munch%2C_1893%2C_The_Scream%2C_oil%2C_tempera_and_pastel_on_cardboard%2C_91_x_73_cm%2C_National_Gallery_of_Norway.jpg",
      "username": "@edvard_munch",
      "timePosted": "1 day ago",
      "likes": 890,
      "comments": 35,
    },
    {
      "id": 4,
      "title": "Guernica",
      "artist": "Picasso",
      "category": "Modern",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Mural_del_Gernika.jpg/1280px-Mural_del_Gernika.jpg",
      "username": "@pablo_picasso",
      "timePosted": "3 days ago",
      "likes": 1520,
      "comments": 67,
    },
    {
      "id": 5,
      "title": "The Kiss",
      "artist": "Klimt",
      "category": "Modern",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/The_Kiss_-_Gustav_Klimt_-_Google_Cultural_Institute.jpg/800px-The_Kiss_-_Gustav_Klimt_-_Google_Cultural_Institute.jpg",
      "username": "@gustav_klimt",
      "timePosted": "1 week ago",
      "likes": 3100,
      "comments": 145,
    },
    {
      "id": 6,
      "title": "Pearl Earring",
      "artist": "Vermeer",
      "category": "Classic",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/1665_Girl_with_a_Pearl_Earring.jpg/800px-1665_Girl_with_a_Pearl_Earring.jpg",
      "username": "@johannes_vermeer",
      "timePosted": "2 weeks ago",
      "likes": 980,
      "comments": 28,
    },
    {
      "id": 7,
      "title": "Birth of Venus",
      "artist": "Botticelli",
      "category": "Classic",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Sandro_Botticelli_-_La_nascita_di_Venere_-_Google_Art_Project_-_edited.jpg/1280px-Sandro_Botticelli_-_La_nascita_di_Venere_-_Google_Art_Project_-_edited.jpg",
      "username": "@sandro_botticelli",
      "timePosted": "3 weeks ago",
      "likes": 1750,
      "comments": 89,
    },
    {
      "id": 8,
      "title": "Persistence",
      "artist": "Dali",
      "category": "Surrealism",
      "image":
          "https://upload.wikimedia.org/wikipedia/en/d/dd/The_Persistence_of_Memory.jpg",
      "username": "@salvador_dali",
      "timePosted": "1 month ago",
      "likes": 2340,
      "comments": 98,
    },
  ];

  // --- 2. STATE VARIABLES ---
  List<Map<String, dynamic>> _foundArts = [];
  List<Map<String, dynamic>> _foundArtists = [];
  String _searchText = "";

  @override
  void initState() {
    _foundArts = _allArts;
    _foundArtists = _allArtists;
    super.initState();
  }

  // --- 3. FILTER LOGIC ---
  void _runFilter() {
    setState(() {
      // Filter Artists (only by text)
      if (_searchText.isEmpty) {
        _foundArtists = _allArtists;
      } else {
        _foundArtists = _allArtists.where((artist) {
          final name = artist["name"] as String? ?? '';
          return name.toLowerCase().contains(_searchText.toLowerCase());
        }).toList();
      }

      // Filter Arts (by text AND category)
      _foundArts = _allArts.where((art) {
        final title = art["title"] as String? ?? '';
        final artist = art["artist"] as String? ?? '';
        final category = art["category"] as String? ?? '';

        final matchesText =
            title.toLowerCase().contains(_searchText.toLowerCase()) ||
            artist.toLowerCase().contains(_searchText.toLowerCase());

        final matchesCategory =
            _selectedCategory == "All" || category == _selectedCategory;

        return matchesText && matchesCategory;
      }).toList();
    });
  }

  void _updateSearchText(String value) {
    _searchText = value;
    _runFilter();
  }

  void _updateCategory(String category) {
    _selectedCategory = category;
    _runFilter();
  }

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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Discover Art',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SEARCH BAR ---
              TextField(
                onChanged: _updateSearchText,
                decoration: InputDecoration(
                  hintText: 'Search artists, paintings...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // --- ARTISTS SECTION (Horizontal List) ---
              if (_foundArtists.isNotEmpty) ...[
                const Text(
                  "Featured Artists",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _foundArtists.length,
                    itemBuilder: (context, index) {
                      final artist = _foundArtists[index];
                      // Null Safety Handling
                      final String artistName = artist['name'] ?? 'Unknown';
                      final String artistImage = artist['image'] ?? '';

                      return Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 15),
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                              child: artistImage.isNotEmpty
                                  ? ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: artistImage,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                              Icons.error,
                                              color: Colors.grey[400],
                                            ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        artistName.isNotEmpty
                                            ? artistName[0]
                                            : '?',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              artistName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],

              const SizedBox(height: 10),

              // --- CATEGORY FILTER ---
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          if (selected) _updateCategory(category);
                        },
                        selectedColor: Colors.deepPurple,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.transparent),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // --- ARTS GRID (2 Columns) ---
              const Text(
                "Gallery",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              _foundArts.isNotEmpty
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                      itemCount: _foundArts.length,
                      itemBuilder: (context, index) {
                        final art = _foundArts[index];
                        // Null Safety Handling
                        final String title = art['title'] ?? 'Unknown';
                        final String artist = art['artist'] ?? 'Unknown';
                        final String imageUrl = art['image'] ?? '';

                        return GestureDetector(
                          onTap: () {
                            _showArtDetailsModal(context, art);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromRGBO(0, 0, 0, 0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Image Section
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(15),
                                    ),
                                    child: imageUrl.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: imageUrl,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                                      color: Colors.grey[300],
                                                      child: const Icon(
                                                        Icons.broken_image,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                          )
                                        : Container(
                                            color: Colors.grey[300],
                                            child: const Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                            ),
                                          ),
                                  ),
                                ),
                                // Text Section
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          artist,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
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
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("No art found matching your criteria."),
                      ),
                    ),
            ],
          ),
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
