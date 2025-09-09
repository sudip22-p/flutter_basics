import 'package:uuid/uuid.dart';

class House {
  final String id;
  final String name;
  final String address;
  final String description;

  House({
    String? id,
    required this.name,
    required this.address,
    required this.description,
  }) : id = id ?? const Uuid().v4();
}
