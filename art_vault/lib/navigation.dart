import 'package:flutter/material.dart';

/// Navigation destinations for the app
class AppNavigationDestination {
  final Widget icon;
  final Widget label;
  final int index;

  AppNavigationDestination({
    required this.icon,
    required this.label,
    required this.index,
  });
}

/// All navigation destinations used in the app
List<AppNavigationDestination> getNavigationDestinations() {
  return [
    AppNavigationDestination(
      icon: const Icon(Icons.photo_library),
      label: const Text('Gallery'),
      index: 0,
    ),
    AppNavigationDestination(
      icon: const Icon(Icons.favorite),
      label: const Text('Favorites'),
      index: 1,
    ),
    AppNavigationDestination(
      icon: const Icon(Icons.info),
      label: const Text('About'),
      index: 2,
    ),
  ];
}

/// Builds a bottom navigation bar for mobile devices
Widget buildBottomNavigationBar({
  required int selectedIndex,
  required ValueChanged<int> onDestinationSelected,
}) {
  final destinations = getNavigationDestinations();

  return NavigationBar(
    selectedIndex: selectedIndex,
    onDestinationSelected: onDestinationSelected,
    destinations: destinations.map((destination) {
      return NavigationDestination(
        icon: destination.icon,
        label: destination.label.data,
      );
    }).toList(),
  );
}

/// Builds a navigation drawer for mobile devices
Widget buildNavigationDrawer({
  required BuildContext context,
  required int selectedIndex,
  required ValueChanged<int> onDestinationSelected,
}) {
  final destinations = getNavigationDestinations();

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.deepOrange),
          child: Text(
            'Art Vault',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...destinations.map((destination) {
          final isSelected = selectedIndex == destination.index;
          return ListTile(
            selected: isSelected,
            selectedTileColor: Colors.deepOrange.withOpacity(0.1),
            leading: destination.icon,
            title: destination.label,
            onTap: () {
              onDestinationSelected(destination.index);
              Navigator.pop(context);
            },
          );
        }).toList(),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            // TODO: Navigate to settings
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

/// Extension to get label text from Widget
extension LabelExtension on Widget {
  String get data {
    if (this is Text) {
      return (this as Text).data ?? '';
    }
    return '';
  }
}
