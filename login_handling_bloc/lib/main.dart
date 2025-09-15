import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_handling_bloc/bloc/auth_bloc.dart';
import 'package:login_handling_bloc/screens/after_login_home.dart';
import 'package:login_handling_bloc/screens/home_page.dart';
import 'package:login_handling_bloc/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => HomePage(),
          "/login": (context) => Login(),
          "/home": (context) => LoginHome(),
        },
      ),
    );
  }
}
