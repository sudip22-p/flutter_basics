import 'package:crud_on_house_list/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_on_house_list/provider/house_provider.dart';
import 'package:crud_on_house_list/provider/wishlist_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HouseProvider>(
          create: (context) => HouseProvider(),
        ),
        ChangeNotifierProvider<WishlistProvider>(
          create: (context) => WishlistProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'House List CRUD',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
