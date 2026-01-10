import 'package:flutter/material.dart';

/// Base class for all screen renderers in the app
abstract class ScreenRenderer extends StatelessWidget {
  final String title;
  const ScreenRenderer({super.key, required this.title});
}
