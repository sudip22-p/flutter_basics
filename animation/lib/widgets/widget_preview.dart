import 'package:flutter/widget_previews.dart';
import 'package:flutter/material.dart';

@Preview(name: 'My Sample Text')
Widget mySampleText() {
  return const Text('Hello, hello!');
}

@Preview(name: 'new widget')
Widget myNewWidget() {
  return Column(children: [Icon(Icons.star, color: Colors.blue[500])]);
}
