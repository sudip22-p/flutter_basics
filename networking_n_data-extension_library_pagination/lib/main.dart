import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:networking_n_data/utils/user.dart';
import 'package:http/http.dart' as http;
import 'package:networking_n_data/packages/package_1.dart';
import 'package:networking_n_data/widgets/extension.dart';
import 'package:networking_n_data/widgets/pagination.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  Future<void> fetchUser() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users/2'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> userData = data['data'];
      setState(() {
        user = User.fromMap(userData);
      });
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
    FeatureA().run();
    FeatureB().run();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Networking and Data',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Networking and Data')),
        body: Container(
          // width: 300,
          // height: 100,
          // constraints: BoxConstraints(maxWidth: 300, maxHeight: 100),
          padding: const EdgeInsets.all(10.0),
          // color: Colors.amber,
          child: Align(
            child: Container(
              // width: 200,
              // height: 100,
              // constraints: BoxConstraints(maxWidth: 200, maxHeight: 80),
              padding: const EdgeInsets.all(10.0),
              // color: Colors.greenAccent,
              child: Align(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  height: double.infinity,
                  // constraints: BoxConstraints(maxWidth: 20, maxHeight: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("user: ${user?.firstName ?? 'Loading...'}"),
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage('assets/img-1.jpg'),
                        ),

                        // CircleAvatar(
                        //   radius: 40,
                        //   backgroundImage: NetworkImage(
                        //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9lcuRjDIqHEcBqxuFEoW5CHy00t_XosQqsZfHnt-R2VEdYW44Ix2kY109MLEC8dtrvGeq6sR7O0Jn4a85nbJpUivim2iWPGpsyMTz6CyD",
                        //   ),
                        // ),

                        // child: Image(
                        //   width: 100,
                        //   height: 100,
                        //   image: NetworkImage(
                        //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9lcuRjDIqHEcBqxuFEoW5CHy00t_XosQqsZfHnt-R2VEdYW44Ix2kY109MLEC8dtrvGeq6sR7O0Jn4a85nbJpUivim2iWPGpsyMTz6CyD",
                        //   ),
                        // ),
                        Text("Start"),
                        Pagination(),
                        Text("bottom"),
                        SizedBox(height: 20),
                        Text("extension"),
                        ExtensionClass(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
