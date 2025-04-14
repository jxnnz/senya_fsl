import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../themes/color.dart';

// Simulated Flashcard Model
class Flashcard {
  final String word;
  final String videoUrl;

  Flashcard({required this.word, required this.videoUrl});
}

class FlashcardSetScreen extends StatefulWidget {
  final String setId;
  final String setTitle;

  const FlashcardSetScreen({
    super.key,
    required this.setId,
    required this.setTitle,
  });

  @override
  State<FlashcardSetScreen> createState() => _FlashcardSetScreenState();
}

class _FlashcardSetScreenState extends State<FlashcardSetScreen>
    with SingleTickerProviderStateMixin {
  late List<Flashcard> flashcards;
  late PageController _pageController;
  int currentIndex = 0;
  bool isFlipped = false;
  Set<int> stillLearning = {};

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();

    // Mock flashcard data
    flashcards = List.generate(
      10,
      (index) => Flashcard(
        word: 'Word ${index + 1}',
        videoUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );

    _pageController = PageController();

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(_flipController);

    _initializeVideo();
  }

  void _initializeVideo() {
    _videoController?.dispose();

    _videoController =
        VideoPlayerController.networkUrl(
            Uri.parse(flashcards[currentIndex].videoUrl),
          )
          ..setLooping(true)
          ..setVolume(0)
          ..initialize().then((_) {
            _videoController?.play();
            setState(() {});
          });
  }

  void _nextCard() {
    setState(() {
      isFlipped = false;
      currentIndex++;
      if (currentIndex < flashcards.length) {
        _initializeVideo();
      }
    });
  }

  void _flipCard() {
    setState(() => isFlipped = !isFlipped);
    if (isFlipped) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _flipController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = flashcards[currentIndex];
    final total = flashcards.length;
    final progress = currentIndex + 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.setTitle),
        leading: BackButton(),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            // --- Progress Bar ---
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress / total,
                    color: AppColors.primaryColor,
                    backgroundColor: Colors.grey[300],
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 10),
                Text('$progress/$total'),
              ],
            ),
            const SizedBox(height: 30),

            // --- Flashcard Flip ---
            Expanded(
              child: GestureDetector(
                onTap: _flipCard,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    final isUnder = (_flipAnimation.value >= 0.5);
                    final transform = Matrix4.rotationY(
                      _flipAnimation.value * 3.14,
                    );

                    return Transform(
                      transform: transform,
                      alignment: Alignment.center,
                      child:
                          isUnder
                              ? Transform(
                                transform: Matrix4.rotationY(
                                  3.14,
                                ), // flip text back
                                alignment: Alignment.center,
                                child: _buildBackCard(flashcard.word),
                              )
                              : _buildFrontCard(_videoController),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- Buttons ---
            if (currentIndex < total - 1) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _feedbackButton(
                    "Still learning",
                    Icons.refresh,
                    Colors.orange,
                    () {
                      stillLearning.add(currentIndex);
                      _nextCard();
                    },
                  ),
                  _feedbackButton(
                    "Got it",
                    Icons.check_circle,
                    Colors.green,
                    () {
                      stillLearning.remove(currentIndex);
                      _nextCard();
                    },
                  ),
                ],
              ),
            ] else
              Column(
                children: [
                  Text(
                    stillLearning.isEmpty
                        ? "🎉 Congrats! You got them all!"
                        : "Almost there! Ready to review?",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (stillLearning.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = 0;
                          stillLearning = Set.from(stillLearning);
                          _initializeVideo();
                        });
                      },
                      child: const Text("Review Again"),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontCard(VideoPlayerController? controller) {
    return SizedBox(
      width: 800, // 👈 tweak width here
      height: 280, // 👈 tweak height here
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child:
              controller != null && controller.value.isInitialized
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  )
                  : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildBackCard(String word) {
    return SizedBox(
      width: 800, // 👈 same size for consistency
      height: 280,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppColors.primaryColor,
        child: Center(
          child: Text(
            word,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _feedbackButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
    );
  }
}
