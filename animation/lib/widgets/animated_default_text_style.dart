import 'package:flutter/material.dart';

class AnimatedDefaultTextStyleExample extends StatefulWidget {
  const AnimatedDefaultTextStyleExample({super.key});

  @override
  State<AnimatedDefaultTextStyleExample> createState() =>
      _AnimatedDefaultTextStyleExampleState();
}

class _AnimatedDefaultTextStyleExampleState
    extends State<AnimatedDefaultTextStyleExample> {
  bool animated = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: AnimatedDefaultTextStyle(
            style: animated
                ? TextStyle(color: Colors.blueAccent, fontSize: 32)
                : TextStyle(color: Colors.black, fontSize: 12),
            duration: Duration(milliseconds: 200),
            child: Text('animated default text style'),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              animated = !animated;
            });
          },
          child: const Text('Animate'),
        ),
      ],
    );
  }
}
