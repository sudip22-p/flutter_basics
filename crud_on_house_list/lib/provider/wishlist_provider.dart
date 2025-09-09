import 'package:crud_on_house_list/utils/house.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<House> _favHouses = [];

  List<House> get houses => _favHouses;

  void addHouse(House house) {
    _favHouses.add(house);
    notifyListeners();
  }

  void removeHouse(String id) {
    _favHouses.removeWhere((house) => house.id == id);
    notifyListeners();
  }

  bool isHouseInWishlist(String id) {
    return _favHouses.any((house) => house.id == id);
  }
}
