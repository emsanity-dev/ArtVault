import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Model for intro slides
class IntroSlide {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradientColors;

  const IntroSlide({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradientColors,
  });
}

/// Introduction/Splash Screen with multiple onboarding pages
class IntroPage extends StatefulWidget {
  final VoidCallback onComplete;

  const IntroPage({super.key, required this.onComplete});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static final List<IntroSlide> _slides = [
    IntroSlide(
      icon: Icons.palette,
      title: 'Art Vault',
      description:
          'Discover famous artworks from around the world in one place.',
      gradientColors: [Colors.deepOrange, Colors.orange],
    ),
    IntroSlide(
      icon: Icons.photo_library,
      title: 'Browse Gallery',
      description:
          'Explore a curated collection of masterpieces from legendary artists.',
      gradientColors: [Colors.blue, Colors.lightBlue],
    ),
    IntroSlide(
      icon: Icons.favorite,
      title: 'Save Favorites',
      description:
          'Build your personal collection by saving your favorite pieces.',
      gradientColors: [Colors.pink, Colors.pinkAccent],
    ),
    IntroSlide(
      icon: Icons.info,
      title: 'Learn More',
      description: 'Discover the stories and artists behind each masterpiece.',
      gradientColors: [Colors.purple, Colors.deepPurple],
    ),
  ];

  void _complete() {
    widget.onComplete();
  }

  @override
  void initState() {
    super.initState();
    // Make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Stack(
          children: [
            // PageView fills the entire screen
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _slides.length,
              itemBuilder: (context, index) {
                return _buildSlide(_slides[index], index);
              },
            ),
            // Skip button positioned at bottom-center
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 16,
              left: 0,
              right: 0,
              child: SafeArea(
                child: TextButton(
                  onPressed: _complete,
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(IntroSlide slide, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: slide.gradientColors,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 32,
          right: 32,
          top: MediaQuery.of(context).padding.top + 80,
          bottom: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(slide.icon, size: 120, color: Colors.white),
            const SizedBox(height: 48),
            Text(
              slide.title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              slide.description,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Get Started button on last page only
            if (index == _slides.length - 1)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _complete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: slide.gradientColors[0],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
