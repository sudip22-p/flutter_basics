import 'package:flutter/material.dart';
import 'package:animation/main.dart';

class HeroAnimationExample extends StatelessWidget {
  const HeroAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HeroFirstScreen()),
        );
      },
      child: const Text(
        'click me',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class HeroFirstScreen extends StatelessWidget {
  const HeroFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Hero Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("tap the logo to see the hero animation"),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(
                      seconds: 2,
                    ), // slower animation
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HeroSecondScreen(),
                  ),
                );
              },
              child: Hero(
                tag: 'hero-logo',
                // Customization of transition look
                flightShuttleBuilder:
                    (
                      flightContext,
                      animation,
                      direction,
                      fromContext,
                      toContext,
                    ) {
                      return RotationTransition(
                        turns: animation,
                        child: Icon(
                          Icons.flutter_dash,
                          color: Colors.blue[300],
                          size: direction == HeroFlightDirection.push
                              ? 240
                              : 48,
                        ),
                      );
                    },
                child: Icon(
                  Icons.flutter_dash,
                  color: Colors.blue[300],
                  size: 48,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroSecondScreen extends StatelessWidget {
  const HeroSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Hero Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Hero(
              tag: 'hero-logo',
              flightShuttleBuilder:
                  (
                    flightContext,
                    animation,
                    direction,
                    fromContext,
                    toContext,
                  ) {
                    return RotationTransition(
                      turns: animation,
                      child: Icon(
                        Icons.flutter_dash,
                        color: Colors.blue[300],
                        size: direction == HeroFlightDirection.push ? 240 : 48,
                      ),
                    );
                  },
              child: Icon(
                Icons.flutter_dash,
                color: Colors.blue[300],
                size: 240,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
