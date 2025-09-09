import 'package:crud_on_house_list/utils/house.dart';
import 'package:flutter/material.dart';

class HouseProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<House> _houses = [
    House(
      name: 'Cozy Cottage',
      address: '123 Main St, Springfield',
      description:
          'A cozy cottage with a beautiful garden. Perfect for a family. The garden is well-maintained and has a variety of flowers. The interior is spacious with a modern kitchen and a large living room. The bedrooms are comfortable and the bathroom has a luxurious bathtub. The cottage is located in a quiet neighborhood, making it ideal for relaxation. The backyard has a small patio area for outdoor dining. The house is also pet-friendly, allowing for a comfortable stay with your furry friends. The cottage is close to local amenities, including shops and parks. The community is friendly and welcoming, making it a great place to live.',
    ),
    House(
      name: 'Modern Apartment',
      address: '456 Elm St, Springfield',
      description:
          'A modern apartment in the heart of the city. It features a sleek design with high-end finishes. The open-plan living area is perfect for entertaining guests. The kitchen is equipped with stainless steel appliances and granite countertops. The bedroom has ample storage space and large windows that let in plenty of natural light. The bathroom is stylish with a walk-in shower. The apartment building offers amenities such as a gym, pool, and rooftop terrace. It is conveniently located near public transport and shopping centers.',
    ),
    House(
      name: 'Spacious Family Home',
      address: '789 Oak St, Springfield',
      description:
          'A spacious family home with four bedrooms and a large backyard. The living room is bright and airy, perfect for family gatherings. The kitchen is modern with plenty of counter space and storage. Each bedroom has built-in wardrobes and the master bedroom features an en-suite bathroom. The backyard is ideal for children to play and has a patio area for outdoor entertaining. The home is located in a family-friendly neighborhood with schools and parks nearby.',
    ),
  ];

  List<House> get houses => _houses;

  void addHouse(House house) {
    _houses.add(house);
    notifyListeners();
  }

  void removeHouse(String id) {
    _houses.removeWhere((house) => house.id == id);
    notifyListeners();
  }

  void updateHouse(String id, House updatedHouse) {
    final index = _houses.indexWhere((house) => house.id == id);
    if (index != -1) {
      _houses[index] = updatedHouse;
      notifyListeners();
    }
  }
}
