import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  List<Map<String, dynamic>> wishlistCatalogue;
  WishlistProvider({List<Map<String, dynamic>>? wishlistCatalogue})
    : wishlistCatalogue = wishlistCatalogue ?? [];
  void addToWishlist(Map<String, dynamic> item) {
    wishlistCatalogue.add(item);
    notifyListeners();
  }

  void removeFromWishlist(Map<String, dynamic> item) {
    wishlistCatalogue.remove(item);
    notifyListeners();
  }

  bool isInWishlist(Map<String, dynamic> item) {
    return wishlistCatalogue.contains(item);
  }

  List<Map<String, dynamic>> getWishlist() {
    return wishlistCatalogue;
  }

  void clearWishlist() {
    wishlistCatalogue.clear();
    notifyListeners();
  }
}
