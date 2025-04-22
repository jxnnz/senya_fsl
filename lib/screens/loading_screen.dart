import 'dart:math';
import 'package:flutter/material.dart';
import '../themes/color.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  final List<String> funFacts = [
    "🤟 Sign languages are not universal—each country has its own!",
    "👋 Facial expressions are *essential* in sign language.",
    "📚 ASL has its own grammar—it’s not just English with hand signs!",
    "🎬 The first sign language movie was released in 1926!",
    "🧠 Learning sign language activates both brain hemispheres!",
    "💡 Sign languages evolve just like spoken ones do.",
    "🚀 NASA astronauts use sign language underwater to train!",
    "🐒 Gorillas like Koko learned hundreds of signs!",
    "🦻 Deaf people invented the first video relay services.",
    "✨ There’s poetry and storytelling in sign language too!",
  ];

  late final String selectedFact;
  late final AnimationController _controller;
  final List<String> letters = ['S', 'E', 'N', 'Y', 'A'];

  @override
  void initState() {
    super.initState();

    // Pick a random fun fact
    final random = Random();
    selectedFact = funFacts[random.nextInt(funFacts.length)];

    // Master controller for the wave
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(); // loop forever

    // Auto-close loading after delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double getBounceOffset(int index, double value) {
    final totalLetters = letters.length;
    final waveSpeed = 2 * pi; // one full wave
    final delay = (index / totalLetters) * waveSpeed;

    // sine wave bounce per letter
    final bounce = sin(value * waveSpeed + delay) * 10; // 25 is height
    return -bounce; // negative = up
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset('assets/images/LOGO.png', height: 120),
                const SizedBox(height: 40),

                // Bouncy wave text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(letters.length, (index) {
                    final animationValue = _controller.value;
                    final bounce = getBounceOffset(index, animationValue);

                    return Transform.translate(
                      offset: Offset(0, bounce),
                      child: Text(
                        letters[index],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.selectedColor,
                          letterSpacing: 10,
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 40),

                // Fun fact
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    selectedFact,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
