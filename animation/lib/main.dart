import 'package:animation/animations/animated_widget.dart';
import 'package:animation/animations/animation_builder.dart';
import 'package:animation/animations/foo_transition_custon.dart';
import 'package:animation/animations/hero_animation.dart';
import 'package:flutter/material.dart';
import 'package:animation/animations/animated_foo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Animation in Flutter')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Animated Foo Examples',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              AnimatedFooExamples(),
              SizedBox(height: 20),
              Text(
                'Foo Transition Examples',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              FooTransition(),
              SizedBox(height: 20),
              Text(
                'Animation Builder Examples',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              AnimationBuilderExample(),
              SizedBox(height: 20),
              Text(
                'AnimatedWidget Examples',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              AnimatedWidgetExample(),
              SizedBox(height: 20),
              Text(
                'click below for Hero animation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              HeroAnimationExample(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
