import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //makes sure Flutter is fully ready before you run any async code like Hive.initFlutter() in main().
  await Hive.initFlutter(); //sets up Hive to work with Flutter's file system.
  await Hive.openBox(
    'myBox',
  ); // opens (or creates) a storage box named 'myBox' to store and access data.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HiveDatabase(),
    );
  }
}
