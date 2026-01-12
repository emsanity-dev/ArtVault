import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../home_screen.dart';
import '../search/search_screen.dart';
import '../../chat/chat_screen.dart';
import '../../profile/components/profile_content.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({super.key, this.currentIndex = 0});

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
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        // Handle navigation
        // Remove the early return for home index

        switch (index) {
          case 0:
            // Navigate to HomeScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileContent()),
            );
            break;
          // Add cases for other indices if needed
          default:
            // Handle other navigation if required
            break;
        }
      },
    );
  }
}
