import 'package:flutter/material.dart';
import 'package:demo_app_without_provider/utils/house_data.dart';

class WishlistProvider extends ChangeNotifier {
  final List<House> wishlists = [];

  void addToWishlist(House house) {
    wishlists.add(house);
    notifyListeners();
  }

  void removeFromWishlist(House house) {
    wishlists.remove(house);
    notifyListeners();
  }

  bool isInWishlist(House house) {
    return wishlists.contains(house);
  }

  List<House> get allItems => wishlists;
}
