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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 1. MOCK DATA
  // We change the data structure to a List of Lists.
  // Each item represents a post, which contains 1 or more image URLs.
  final List<List<String>> _posts = List.generate(21, (index) {
    // Every 3rd post is a "Carousel" with 3 images
    if (index % 3 == 0) {
      return [
        'https://picsum.photos/600?random=${index}_1',
        'https://picsum.photos/600?random=${index}_2',
        'https://picsum.photos/600?random=${index}_3',
      ];
    }
    // Otherwise, it's a single image post
    return ['https://picsum.photos/600?random=$index'];
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- App Bar ---
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            Text(
              "design_guru",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.black),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      // --- Body ---
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate([_buildProfileHeader()]),
                ),
              ];
            },
            body: Column(
              children: [
                const TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Icon(Icons.grid_on_outlined)),
                    Tab(icon: Icon(Icons.person_pin_outlined)),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildPhotoGrid(), // The main grid
                      _buildTaggedGrid(), // The tagged grid
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar & Stats
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/id/64/200',
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn("142", "Posts"),
                    _buildStatColumn("12.5k", "Followers"),
                    _buildStatColumn("340", "Following"),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Bio Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Alex The Creator",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                "🎨 Digital Artist & UI/UX Designer\n📍 San Francisco, CA",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "www.alexdesigns.com",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Action Buttons
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(child: _buildActionButton("Edit Profile")),
              const SizedBox(width: 8),
              Expanded(child: _buildActionButton("Share Profile")),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(Icons.person_add_outlined, size: 18),
              ),
            ],
          ),
        ),

        // Highlights
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildHighlightItem(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn(String num, String label) {
    return Column(
      children: [
        Text(
          num,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildActionButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }

  Widget _buildHighlightItem(int index) {
    final titles = ["Travel", "Work", "Food", "Gym", "Art"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://picsum.photos/200?random=$index',
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(titles[index], style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // --- NEW MODAL LOGIC ---
  void _showImageModal(BuildContext context, List<String> images) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // PageController for programmatic scrolling (Next/Prev buttons)
        final PageController pageController = PageController();

        // We use StatefulBuilder here because we need to update the
        // dots and buttons when the user swipes, but we don't want to
        // rebuild the entire ProfileScreen.
        return StatefulBuilder(
          builder: (context, setState) {
            // Calculate current page based on controller info or default to 0
            int currentIndex = 0;
            if (pageController.hasClients) {
              currentIndex = pageController.page?.round() ?? 0;
            }

            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  // Background overlay to close modal when tapped outside
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  // 2. Main Content Card
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // -- Header (User info) --
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                    'https://picsum.photos/id/64/200',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'design_guru',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'San Francisco, CA',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.more_vert, size: 20),
                              ],
                            ),
                          ),

                          // -- IMAGE AREA with BUTTONS --
                          SizedBox(
                            height: 400, // Constrain height
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // A. The Scrollable Images
                                PageView.builder(
                                  controller: pageController,
                                  itemCount: images.length,
                                  onPageChanged: (idx) {
                                    setState(() {
                                      currentIndex = idx;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      images[index],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),

                                // B. Previous Button
                                // Logic: Only show if index > 0 AND multiple images exist
                                if (currentIndex > 0 && images.length > 1)
                                  Positioned(
                                    left: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        pageController.previousPage(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.chevron_left,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ),

                                // C. Next Button
                                // Logic: Only show if index < length - 1 AND multiple images exist
                                if (currentIndex < images.length - 1 &&
                                    images.length > 1)
                                  Positioned(
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        pageController.nextPage(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.chevron_right,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // -- Actions Row (Likes, Comments, DOTS) --
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.favorite_border, size: 26),
                                const SizedBox(width: 12),
                                const Icon(Icons.chat_bubble_outline, size: 26),
                                const SizedBox(width: 12),
                                const Icon(Icons.send_outlined, size: 26),

                                // -- DOT INDICATOR --
                                Expanded(
                                  child: Center(
                                    // Logic: Only show dots if there are multiple images
                                    child: images.length > 1
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: List.generate(
                                              images.length,
                                              (index) => Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                    ),
                                                width: 6,
                                                height: 6,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  // Logic: Blue if active, Grey if inactive
                                                  color: currentIndex == index
                                                      ? Colors.blue
                                                      : Colors.grey.withOpacity(
                                                          0.4,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ),

                                const Icon(Icons.bookmark_border, size: 26),
                              ],
                            ),
                          ),

                          // -- Details (Likes, Caption) --
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '1,248 likes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'design_guru ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Exploring specific design patterns in Flutter. ',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: '#flutter #code #design',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPhotoGrid() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: _posts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        final postImages = _posts[index];
        final bool isMultiple = postImages.length > 1;

        return GestureDetector(
          onTap: () {
            // Pass the entire list of images to the modal
            _showImageModal(context, postImages);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Always show the first image in the grid
              Image.network(postImages[0], fit: BoxFit.cover),
              // If multiple, show a "copy" icon in top right (standard UI pattern)
              if (isMultiple)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.copy, // Looks like a stack of photos
                    color: Colors.white,
                    size: 16,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaggedGrid() {
    // Basic grid for the second tab
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Treat tagged posts as single images for this demo
            _showImageModal(context, [
              'https://picsum.photos/600?random=${index + 50}',
            ]);
          },
          child: Image.network(
            'https://picsum.photos/600?random=${index + 50}',
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
