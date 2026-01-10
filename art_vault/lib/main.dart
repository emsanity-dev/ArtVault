import 'package:flutter/material.dart';
import 'screens/intro/intro_page.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Art Vault',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          secondary: Colors.amber,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var showIntro = true;
  var isAuthenticated = false;

  void _completeIntro() {
    setState(() {
      showIntro = false;
    });
  }

  void _onAuthComplete() {
    setState(() {
      isAuthenticated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showIntro) {
      return IntroPage(onComplete: _completeIntro);
    }

    if (!isAuthenticated) {
      return AuthPage(onAuthComplete: _onAuthComplete);
    }

    // Navigate to HomeScreen after authentication
    return const HomeScreen();
  }
}
