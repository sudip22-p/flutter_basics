import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'wishlist_screen.dart';
import 'package:demo_app1/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> catalogItems = [
    {'id': 1, 'name': 'house 1'},
    {'id': 2, 'name': 'house 2'},
    {'id': 3, 'name': 'house 3'},
    {'id': 4, 'name': 'house 4'},
    {'id': 5, 'name': 'house 5'},
    {'id': 6, 'name': 'house 6'},
    {'id': 7, 'name': 'house 7'},
    {'id': 8, 'name': 'house 8'},
    {'id': 9, 'name': 'house 9'},
    {'id': 10, 'name': 'house 10'},
    {'id': 11, 'name': 'house 11'},
    {'id': 12, 'name': 'house 12'},
    {'id': 13, 'name': 'house 13'},
    {'id': 14, 'name': 'house 14'},
    {'id': 15, 'name': 'house 15'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_outline_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Wishlist()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: catalogItems.map((item) {
                return Container(
                  margin: EdgeInsets.all(7.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<WishlistProvider>(
                        builder: (context, wishlistProvider, child) {
                          bool isInWishlist = containsItemByKey(
                            wishlistProvider,
                            'id',
                            item['id'],
                          );
                          return ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                isInWishlist ? Colors.red : Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              if (isInWishlist) {
                                // Remove from wishlist
                                context
                                    .read<WishlistProvider>()
                                    .removeFromWishlist(item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${item['name']} removed from wishlist',
                                    ),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else {
                                // Add to wishlist
                                context.read<WishlistProvider>().addToWishlist(
                                  item,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${item['name']} added to wishlist',
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              isInWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_outline_outlined,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  bool containsItemByKey(WishlistProvider provider, String key, dynamic value) {
    List<Map<String, dynamic>> listItems = provider.getWishlist();
    return listItems.any((item) => item[key] == value);
  }
}
