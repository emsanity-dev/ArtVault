import 'package:flutter/material.dart';
import '../search/search_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline, size: 32),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // Handle navigation
        if (index == 0) return; // Home - already here

        switch (index) {
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
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
