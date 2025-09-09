import 'package:flutter/material.dart';
import 'package:demo_app_without_provider/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/wishlist_provider.dart';

void main() {
  runApp(WishlistApp());
}

class WishlistApp extends StatelessWidget {
  const WishlistApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WishlistProvider(),
      child: MaterialApp(
        title: 'State Management',
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
