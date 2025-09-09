import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_storage_new/screens/add_house.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_storage_new/screens/login_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Box box = Hive.box('myBox');
  String? username;
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final SharedPreferences preference = await SharedPreferences.getInstance();
    setState(() {
      username = preference.getString('username');
    });
  }

  void _logOut() async {
    final SharedPreferences preference = await SharedPreferences.getInstance();
    if (username != null) {
      await preference.remove('username');
    }
    setState(() {
      username = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          children: [
            const Text("Welcome to the Home Page!"),
            const SizedBox(height: 20),
            Text(username ?? "Guest", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginForm()),
                );
              },
              child: const Text('Logout'),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, Box box, _) {
                  if (box.isEmpty) {
                    return Center(child: Text('No houses yet 😢'));
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final item = box.getAt(index);
                      return ListTile(
                        title: Text(item['houseName']),
                        subtitle: Text(
                          '${item['location']} - \$${item['price']}',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHouse()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
