//prevents full rebuilds of the whole widget tree on each animation tick
import 'package:flutter/material.dart';

class AnimatedWidgetExample extends StatefulWidget {
  const AnimatedWidgetExample({super.key});

  @override
  State<AnimatedWidgetExample> createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Controls the timeline of the animation (0.0 → 1.0)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true); // heartbeat effect

    // Scale animation: 1.0 → 1.3 (grow) → 1.0 (shrink)
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: HeartIcon(animation: _scaleAnimation));
  }
}

// Custom widget that listens to animation
class HeartIcon extends AnimatedWidget {
  const HeartIcon({super.key, required Animation<double> animation})
    : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: Icon(Icons.favorite, color: Colors.blueAccent, size: 100),
    );
  }
}
