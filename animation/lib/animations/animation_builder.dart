// Remember in implicit animations what we did if all the AnimatedFoo widgets were not enough for our animation purpose? We used the TweenAnimationBuilder to animate a property not covered in AnimatedFoo widgets. Similarly, in explicit animations, we can use the AnimatedBuilder widget to animate any and/or multiple widget properties.
import 'package:flutter/material.dart';

class AnimationBuilderExample extends StatefulWidget {
  const AnimationBuilderExample({super.key});

  @override
  State<AnimationBuilderExample> createState() =>
      _AnimationBuilderExampleState();
}

class _AnimationBuilderExampleState extends State<AnimationBuilderExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Colors.blue, Colors.purple, Colors.red],
              stops: [0, _controller.value, 1],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white),
          ),
        );
      },
    );
  }
}
