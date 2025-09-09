import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_app_without_provider/providers/wishlist_provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: ListView.builder(
        itemCount: context.watch<WishlistProvider>().wishlists.length,
        itemBuilder: (context, index) {
          final house = context.watch<WishlistProvider>().wishlists[index];
          return ListTile(
            title: Text(house.name),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                if (context.read<WishlistProvider>().isInWishlist(house)) {
                  context.read<WishlistProvider>().removeFromWishlist(house);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${house.name} removed from wishlist'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
