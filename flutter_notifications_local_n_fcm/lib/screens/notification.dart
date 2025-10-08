import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notifications_local_n_fcm/screens/notification_detail_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _local = FlutterLocalNotificationsPlugin();
  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<RemoteMessage>? _tapSub;
  static const _channelId = 'high_importance_channel';

  @override
  void initState() {
    super.initState();
    if (!Platform.isAndroid) return; // Android-only
    _init();
  }

  Future<void> _init() async {
    // init local notifications + channel
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    // await _local.initialize(const InitializationSettings(android: androidInit));
    await _local.initialize(
      const InitializationSettings(android: androidInit),
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null && mounted) {
          final data = jsonDecode(response.payload!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NotificationDetailScreen(
                title: data['title'],
                body: data['body'],
              ),
            ),
          );
        }
      },
    );
    const channel = AndroidNotificationChannel(
      _channelId,
      'High Importance',
      description: 'Important notifications',
      importance: Importance.high,
    );
    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Request permission (Android 13+ shows runtime prompt)
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('Permission: ${settings.authorizationStatus}');

    // Print token for Firebase Console
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM token: $token');

    // foreground messages
    _foregroundSub = FirebaseMessaging.onMessage.listen((msg) async {
      // get title/body (may be null for data-only)
      final t = msg.notification?.title ?? 'N/A';
      final b = msg.notification?.body ?? 'N/A';

      // simple dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(t),
            content: Text(b, maxLines: 2, overflow: TextOverflow.ellipsis),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          NotificationDetailScreen(title: t, body: b),
                    ),
                  );
                },
                child: const Text('Open'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }

      // local notification
      const androidDetails = AndroidNotificationDetails(
        _channelId,
        'High Importance',
        channelDescription: 'Important notifications',
        importance: Importance.max,
        priority: Priority.high,
      );
      // while showing the notification
      final payloadData = {"title": t, "body": b};
      await _local.show(
        msg.hashCode,
        t,
        b,
        const NotificationDetails(android: androidDetails),
        payload: jsonEncode(payloadData), // encode to string
      );
    });

    // onMessageOpenedApp -> navigate
    _tapSub = FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      final t = msg.notification?.title ?? 'N/A';
      final b = msg.notification?.body ?? 'N/A';
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NotificationDetailScreen(title: t, body: b),
        ),
      );
    });

    // launched from notification (terminated)
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null && mounted) {
      final t = initial.notification?.title ?? 'N/A';
      final b = initial.notification?.body ?? 'N/A';
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NotificationDetailScreen(title: t, body: b),
        ),
      );
    }
  }

  @override
  void dispose() {
    _foregroundSub?.cancel();
    _tapSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Push Notification')),
      body: const Center(child: Text('Listening for notifications')),
    );
  }
}
