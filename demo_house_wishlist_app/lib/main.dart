import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/wishlist_provider.dart';

void main() {
  runApp(AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],
      child: MaterialApp(
        title: 'Auth UI Demo',
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
