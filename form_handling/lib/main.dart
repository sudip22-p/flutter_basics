import 'package:flutter/material.dart';
import 'package:form_handling/screens/login_screen.dart';

void main() {
  runApp(AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth UI Demo',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
