import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _isLoaded = false;
  bool showIntro = true;
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      showIntro = prefs.getBool('showIntro') ?? true;
      isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
      _isLoaded = true;
    });
  }

  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _completeIntro() {
    setState(() {
      showIntro = false;
    });
    _savePreference('showIntro', false);
  }

  void _onAuthComplete() {
    setState(() {
      isAuthenticated = true;
    });
    _savePreference('isAuthenticated', true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
