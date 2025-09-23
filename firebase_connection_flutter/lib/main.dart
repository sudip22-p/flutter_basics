import 'package:firebase_connection_flutter/bloc/auth_bloc.dart';
import 'package:firebase_connection_flutter/firebase_options.dart';
import 'package:firebase_connection_flutter/screens/after_login_home.dart';
import 'package:firebase_connection_flutter/screens/home_page.dart';
import 'package:firebase_connection_flutter/screens/login.dart';
import 'package:firebase_connection_flutter/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          "/signup": (context) => SignUp(),
          "/home": (context) => LoginHome(),
        },
      ),
    );
  }
}
