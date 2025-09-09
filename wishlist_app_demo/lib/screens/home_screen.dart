import 'package:flutter/material.dart';
import 'package:demo_app_without_provider/utils/house_data.dart';
import 'package:demo_app_without_provider/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:demo_app_without_provider/providers/wishlist_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int count = -1;
  @override
  Widget build(BuildContext context) {
    count++;
    print('Building HomeScreen with ${houseCatalog.length} houses');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.green),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WishlistScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text(count.toString()),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: houseCatalog.length,
              itemBuilder: (context, index) {
                final house = houseCatalog[index];
                final isInWishlistNow = context
                    .watch<WishlistProvider>()
                    .isInWishlist(house);
                final isInWishlist = context
                    .read<WishlistProvider>()
                    .isInWishlist(house);
                return ListTile(
                  title: Text(house.name),
                  trailing: IconButton(
                    icon: Icon(
                      isInWishlistNow ? Icons.favorite : Icons.favorite_border,
                      color: isInWishlistNow ? Colors.red : null,
                    ),
                    onPressed: () {
                      // Add functionality to add to wishlist
                      if (!isInWishlist) {
                        context.read<WishlistProvider>().addToWishlist(house);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${house.name} added to wishlist'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${house.name} is already in wishlist',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
