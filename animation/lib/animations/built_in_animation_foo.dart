import 'package:animation/widgets/animated_align.dart';
import 'package:animation/widgets/animated_container_example.dart';
import 'package:animation/widgets/animated_default_text_style.dart';
import 'package:animation/widgets/animated_opacity.dart';
import 'package:flutter/material.dart';

class BuiltInAnimationFoo extends StatelessWidget {
  const BuiltInAnimationFoo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedDefaultTextStyleExample(),
        SizedBox(height: 20),
        AnimatedAlignExample(),
        SizedBox(height: 20),
        AnimatedContainerExample(),
        SizedBox(height: 20),
        AnimatedOpacityExample(),
        SizedBox(height: 20),
        //others: AnimatedPadding, AnimatedPositioned(works with stack -position changed animatically ), AnimatedSize(change size with animation), AnimatedPhysicalModel( borderRadius and elevation are animated.)
      ],
    );
  }
}
