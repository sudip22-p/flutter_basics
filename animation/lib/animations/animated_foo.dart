import 'package:flutter/material.dart';
import 'package:animation/animations/built_in_animation_foo.dart';
import 'package:animation/animations/tween_animation_builder.dart';

class AnimatedFooExamples extends StatelessWidget {
  const AnimatedFooExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Built-in Animated Foo Examples',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        BuiltInAnimationFoo(),
        SizedBox(height: 20),
        Text(
          'Tween Animation Builder Examples',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TweenAnimationBuilderExample(),
      ],
    );
  }
}
