import 'package:flutter/material.dart';

class LoginHome extends StatelessWidget {
  const LoginHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Page"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "welcome home -- logged successfully...",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
