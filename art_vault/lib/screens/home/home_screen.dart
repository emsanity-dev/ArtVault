import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Adjust these imports to match your actual folder structure
import 'components/custom_app_bar.dart';
import 'components/post_card.dart';
import 'components/highlight_cards.dart';
import 'search/search_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/components/profile_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoaded = false;
  int _currentIndex = 0;

  late final List<Widget> _bodies;
  late final List<PreferredSizeWidget?> _appBars;

  Future<void> _loadCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentIndex = prefs.getInt('currentIndex') ?? 0;
      _isLoaded = true;
    });
  }

  Future<void> _saveCurrentIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentIndex', index);
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentIndex();
    _bodies = [
      // Home body
      CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const HighlightCards(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => PostCard(index: index),
              childCount: 10,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      // Search body
      const SearchScreen(),
      // Placeholder for Create
      const Center(child: Text('Create')),
      // Chat Screen
      const ChatScreen(),
      // Profile Screen
      const ProfileContent(),
    ];

    _appBars = [
      const CustomAppBar(), // Home
      null, // Search - no app bar
      null, // Create - no app bar
      null, // Chat - no app bar (ChatScreen handles its own UI)
      null, // Profile - no app bar
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      // FIX 1: Prevents the screen from resizing/overflowing when keyboard opens
      resizeToAvoidBottomInset: false,

      // FIX 2: Allows the content to draw behind the curved nav bar
      extendBody: true,

      appBar: _appBars[_currentIndex],

      body: _bodies[_currentIndex],

      bottomNavigationBar: CurvedBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _saveCurrentIndex(index);
        },
      ),
    );
  }
}

// Kept this component here for easy access, or move to its own file
class CurvedBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CurvedBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 60.0,
      items: const [
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.search, size: 30, color: Colors.white),
        Icon(Icons.add_circle_outline, size: 30, color: Colors.white),
        Icon(Icons.chat_bubble_outline, size: 30, color: Colors.white),
        Icon(Icons.person_outline, size: 30, color: Colors.white),
      ],
      color: Colors.blue,
      buttonBackgroundColor: Colors.blue,
      backgroundColor: Colors.transparent, // Important for extendBody: true
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: onTap,
      letIndexChange: (index) => true,
    );
  }
}
