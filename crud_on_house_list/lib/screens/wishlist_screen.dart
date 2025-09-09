import 'package:flutter/material.dart';
import 'package:crud_on_house_list/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:crud_on_house_list/widgets/house_details_popup.dart';

class WishlistScreen extends StatefulWidget {
  
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, child) {
          final houses = wishlistProvider.houses;
          if (houses.isEmpty) {
            return const Center(child: Text('No houses in wishlist'));
          }
          return ListView.builder(
            itemCount: houses.length,
            itemBuilder: (context, index) {
              final house = houses[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return HouseDetailsPopup(
                        name: house.name,
                        address: house.address,
                        description: house.description,
                      );
                    },
                  );
                },
                child: ListTile(
                  title: Text(house.name),
                  subtitle: Text(house.address),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      wishlistProvider.removeHouse(house.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${house.name} removed from wishlist'),
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
