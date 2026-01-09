import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtVaultState(),
      child: MaterialApp(
        title: 'Art Vault',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            secondary: Colors.amber,
          ),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class ArtVaultState extends ChangeNotifier {
  // Art data for the vault
  var currentArtIndex = 0;

  final List<ArtPiece> artCollection = [
    ArtPiece(
      title: 'Starry Night',
      artist: 'Vincent van Gogh',
      year: 1889,
      description:
          'A post-impressionist masterpiece depicting a view from the east-facing window of his asylum room.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1280px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
    ),
    ArtPiece(
      title: 'The Mona Lisa',
      artist: 'Leonardo da Vinci',
      year: 1503,
      description:
          'A half-length portrait painting by Italian artist Leonardo da Vinci.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/800px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg',
    ),
    ArtPiece(
      title: 'The Scream',
      artist: 'Edvard Munch',
      year: 1893,
      description:
          'An iconic expressionist painting representing the anxiety of the human being.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Edvard_Munch%2C_1893%2C_The_Scream%2C_oil%2C_tempera_and_pastel_on_cardboard%2C_91_x_73.5_cm%2C_National_Gallery_of_Norway.jpg/800px-Edvard_Munch%2C_1893%2C_The_Scream%2C_oil%2C_tempera_and_pastel_on_cardboard%2C_91_x_73.5_cm%2C_National_Gallery_of_Norway.jpg',
    ),
    ArtPiece(
      title: 'Girl with a Pearl Earring',
      artist: 'Johannes Vermeer',
      year: 1665,
      description:
          'A tronie of a girl wearing a headscarf and a pearl earring.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/1665_Girl_with_a_Pearl_Earring.jpg/800px-1665_Girl_with_a_Pearl_Earring.jpg',
    ),
    ArtPiece(
      title: 'The Persistence of Memory',
      artist: 'Salvador Dalí',
      year: 1931,
      description: 'A surrealist painting featuring melting pocket watches.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/d/dd/The_Persistence_of_Memory.jpg',
    ),
  ];

  ArtPiece get currentArt => artCollection[currentArtIndex];

  void getNextArt() {
    if (currentArtIndex < artCollection.length - 1) {
      currentArtIndex++;
    } else {
      currentArtIndex = 0;
    }
    notifyListeners();
  }

  void getPreviousArt() {
    if (currentArtIndex > 0) {
      currentArtIndex--;
    } else {
      currentArtIndex = artCollection.length - 1;
    }
    notifyListeners();
  }

  // Favorites functionality
  var favorites = <ArtPiece>[];

  void toggleFavorite() {
    if (favorites.contains(currentArt)) {
      favorites.remove(currentArt);
    } else {
      favorites.add(currentArt);
    }
    notifyListeners();
  }

  bool isFavorite(ArtPiece art) => favorites.contains(art);
}

class ArtPiece {
  final String title;
  final String artist;
  final int year;
  final String description;
  final String imageUrl;

  ArtPiece({
    required this.title,
    required this.artist,
    required this.year,
    required this.description,
    required this.imageUrl,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const GalleryPage();
        break;
      case 1:
        page = const FavoritesPage();
        break;
      case 2:
        page = const AboutPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: page,
      ),
      bottomNavigationBar: buildBottomNavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}

// ============================================================================
// Screen Renderer - Base class for all screens
// ============================================================================

abstract class ScreenRenderer extends StatelessWidget {
  final String title;
  const ScreenRenderer({super.key, required this.title});
}

// ============================================================================
// Gallery Page - Main art display screen
// ============================================================================

class GalleryPage extends ScreenRenderer {
  const GalleryPage({super.key}) : super(title: 'Art Gallery');

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ArtVaultState>();
    var art = appState.currentArt;
    var isFavorite = appState.isFavorite(art);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ArtCard(art: art),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.getPreviousArt();
                },
                icon: const Icon(Icons.navigate_before),
                label: const Text('Previous'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                label: Text(isFavorite ? 'Remove' : 'Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFavorite
                      ? Theme.of(context).colorScheme.errorContainer
                      : null,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  appState.getNextArt();
                },
                icon: const Icon(Icons.navigate_next),
                label: const Text('Next'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ArtCard extends StatelessWidget {
  final ArtPiece art;

  const ArtCard({super.key, required this.art});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Art image placeholder
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 64,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Art Preview',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${art.year}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  art.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'by ${art.artist}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  art.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Favorites Page - Shows saved art pieces
// ============================================================================

class FavoritesPage extends ScreenRenderer {
  const FavoritesPage({super.key}) : super(title: 'My Favorites');

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ArtVaultState>();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        Expanded(
          child: appState.favorites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No favorites yet',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start adding art pieces from the gallery!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: appState.favorites.length,
                  itemBuilder: (context, index) {
                    var art = appState.favorites[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.image, color: Colors.white),
                        ),
                        title: Text(
                          art.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${art.artist} (${art.year})'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            appState.favorites.remove(art);
                            appState.notifyListeners();
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ============================================================================
// About Page - App information
// ============================================================================

class AboutPage extends ScreenRenderer {
  const AboutPage({super.key}) : super(title: 'About Art Vault');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.palette, size: 80, color: Colors.deepOrange),
                const SizedBox(height: 16),
                Text(
                  'Art Vault',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'About',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Art Vault is your personal digital gallery, allowing you to explore '
                  'famous artworks from around the world. Browse through our curated '
                  'collection, learn about legendary artists, and save your favorite '
                  'pieces to build your own art collection.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Text(
                  'Features',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildFeatureItem(
                  context,
                  Icons.collections,
                  'Browse art collection',
                ),
                _buildFeatureItem(context, Icons.favorite, 'Save favorites'),
                _buildFeatureItem(context, Icons.info, 'Learn about artists'),
                _buildFeatureItem(
                  context,
                  Icons.mobile_friendly,
                  'Responsive design',
                ),
                const SizedBox(height: 24),
                Text(
                  'Tech Stack',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildFeatureItem(context, Icons.code, 'Flutter'),
                _buildFeatureItem(
                  context,
                  Icons.architecture,
                  'Provider State Management',
                ),
                _buildFeatureItem(context, Icons.palette, 'Material Design 3'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
