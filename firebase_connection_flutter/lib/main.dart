import 'package:firebase_connection_flutter/bloc/auth/auth_bloc.dart';
import 'package:firebase_connection_flutter/bloc/task/task_bloc.dart';
import 'package:firebase_connection_flutter/firebase_options.dart';
import 'package:firebase_connection_flutter/screens/after_login_home.dart';
import 'package:firebase_connection_flutter/screens/home_page.dart';
import 'package:firebase_connection_flutter/screens/login.dart';
import 'package:firebase_connection_flutter/screens/signup.dart';
import 'package:firebase_connection_flutter/services/firestore_task_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestoreService = FirestoreTaskService();
  runApp(MyApp(firestoreService: firestoreService));
}

class MyApp extends StatelessWidget {
  final FirestoreTaskService firestoreService;
  const MyApp({super.key, required this.firestoreService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(
          create: (context) => TaskBloc(firestoreService: firestoreService),
        ),
      ],
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
