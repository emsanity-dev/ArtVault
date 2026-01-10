import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// Adjust these imports to match your actual folder structure
import '../screen_renderer.dart'; 
import 'components/custom_app_bar.dart';
import 'components/post_card.dart';

class HomeScreen extends ScreenRenderer {
  const HomeScreen({super.key}) : super(title: 'Home');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FIX 1: Prevents the screen from resizing/overflowing when keyboard opens
      resizeToAvoidBottomInset: false,

      // FIX 2: Allows the content to draw behind the curved nav bar
      extendBody: true,

      appBar: const CustomAppBar(),
      
      body: ListView.builder(
        // FIX 3: Add padding at bottom so the last item is visible above the nav bar
        padding: const EdgeInsets.only(bottom: 100), 
        itemCount: 10,
        itemBuilder: (context, index) {
          return PostCard(index: index);
        },
      ),
      
      bottomNavigationBar: CurvedBottomNavigation(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return; // Already on Home

          // Navigation logic
          final screenNames = ['', 'Discover', 'Create', 'Chat', 'Profile'];
          if (index > 0 && index < screenNames.length) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Navigating to ${screenNames[index]}')),
            );
          }
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