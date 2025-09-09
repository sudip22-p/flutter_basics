import 'package:flutter/material.dart';

class FooTransition extends StatefulWidget {
  const FooTransition({super.key});

  @override
  State<FooTransition> createState() => _FooTransitionState();
}

class _FooTransitionState extends State<FooTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    //Drives the whole animation timeline (0 → 1 → 0, because reverse: true).
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    //Animate alignment from left → right (and back) with easing
    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    //Animate rotation in "turns" (1.0 = 360°). Here: 0 → 2 turns
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      height: 200,
      child: AlignTransition(
        // moves child using the alignment animation
        alignment: _alignAnimation,
        child: RotationTransition(
          // rotates child using the rotation animation
          turns: _rotationAnimation,
          child: Container(color: Colors.blueAccent, width: 50, height: 50),
        ),
      ),
    );
  }
}
// list of available FooTransition widgets:

// 1. AlignTransition - Aligns a widget using an animation
// 2. DecoratedBoxTransition - Animates the decoration of a box
// 3. DefaultTextStyleTransition - Animates the default text style
// 4. FadeTransition - Fades a widget in and out
// 5. PositionedTransition - Animates the position of a widget
// 6. RelativePositionedTransition - Animates the position of a widget relative to its normal position
// 7. RotationTransition - Rotates a widget
// 8. ScaleTransition - Scales a widget
// 9. ScaleTransition - Scales a widget
// 10. SizeTransition - Animates the size of a widget
// 11. SlideTransition - Slides a widget in and out
// 12. StatusTransitionWidget - Animates the status of a widget
