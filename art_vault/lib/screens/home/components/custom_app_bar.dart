import 'package:flutter/material.dart';
import 'profile_header.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: ProfileHeader());
  }

  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}
