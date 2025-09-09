import 'package:flutter/material.dart';
import 'package:crud_on_house_list/screens/house_form_screen.dart';
import 'package:crud_on_house_list/provider/house_provider.dart';
import 'package:crud_on_house_list/utils/house.dart';
import 'package:crud_on_house_list/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class HouseActions extends StatelessWidget {
  final House house;

  const HouseActions({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      tooltip: 'More options',
      onSelected: (value) {
        switch (value) {
          case 'edit':
            _navigateToEditScreen(context);
            break;
          case 'delete':
            _showDeleteConfirmation(context);
            break;
          case 'wishlist':
            _addToWishlist(context);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, size: 20),
              SizedBox(width: 12),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red, size: 20),
              SizedBox(width: 12),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'wishlist',
          child: Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.pink, size: 20),
              SizedBox(width: 12),
              Text('Add to Wishlist', style: TextStyle(color: Colors.pink)),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HouseFormScreen(house: house)),
    );
  }

  void _addToWishlist(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(
      context,
      listen: false,
    );
    if (wishlistProvider.isHouseInWishlist(house.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${house.name} is already in your wishlist'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    wishlistProvider.addHouse(house);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${house.name} added to wishlist'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.pink,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete House'),
        content: Text('Are you sure you want to delete "${house.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _deleteHouse(context),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteHouse(BuildContext context) {
    Navigator.pop(context);
    Provider.of<HouseProvider>(context, listen: false).removeHouse(house.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${house.name} deleted successfully'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
