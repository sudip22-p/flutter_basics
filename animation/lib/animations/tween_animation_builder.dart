import 'package:flutter/material.dart';

class TweenAnimationBuilderExample extends StatefulWidget {
  const TweenAnimationBuilderExample({super.key});

  @override
  State<TweenAnimationBuilderExample> createState() =>
      _TweenAnimationBuilderExampleState();
}

class _TweenAnimationBuilderExampleState
    extends State<TweenAnimationBuilderExample> {
  double _targetScale = 1.0;
  void _animateCart() {
    setState(() {
      _targetScale = _targetScale == 1.0 ? 1.5 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 1.0, end: _targetScale),
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Icon(Icons.shopping_cart, size: 60, color: Colors.blue),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          onPressed: _animateCart,
          child: Icon(Icons.add_shopping_cart),
        ),
      ],
    );
  }
}
