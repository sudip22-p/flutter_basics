import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatelessWidget {
  final String title;
  final String body;
  const NotificationDetailScreen({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Screen ")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title), const SizedBox(height: 8), Text(body)],
        ),
      ),
    );
  }
}
