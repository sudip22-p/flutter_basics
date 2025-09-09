import 'package:flutter/material.dart';

class AnimatedAlignExample extends StatefulWidget {
  const AnimatedAlignExample({super.key});

  @override
  State<AnimatedAlignExample> createState() => _AnimatedAlignExampleState();
}

class _AnimatedAlignExampleState extends State<AnimatedAlignExample> {
  bool boxClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          boxClicked = !boxClicked;
        });
      },
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: AnimatedAlign(
              alignment: boxClicked ? Alignment.topRight : Alignment.bottomLeft,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Container(height: 50, width: 50, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
