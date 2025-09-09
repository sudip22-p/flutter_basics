import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_app1/providers/wishlist_provider.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            icon: Icon(Icons.arrow_circle_left, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text("Wishlists", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: Column(
              children: context.watch<WishlistProvider>().getWishlist().map((
                item,
              ) {
                if (context.watch<WishlistProvider>().getWishlist().isEmpty) {
                  return Center(
                    child: Text(
                      "Your wishlist is empty",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }
                return Container(
                  margin: EdgeInsets.all(7.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
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
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Logic to remove item from wishlist
                          context.read<WishlistProvider>().removeFromWishlist(
                            item,
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
}
