import 'package:crud_on_house_list/utils/house.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_on_house_list/provider/house_provider.dart';

class HouseFormScreen extends StatefulWidget {
  final House? house;
  const HouseFormScreen({super.key, this.house});

  @override
  State<HouseFormScreen> createState() => _HouseFormScreenState();
}

class _HouseFormScreenState extends State<HouseFormScreen> {
  final GlobalKey<FormState> _houseFormScreenKey = GlobalKey<FormState>();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.house != null) {
      _houseNameController.text = widget.house!.name;
      _addressController.text = widget.house!.address;
      _descriptionController.text = widget.house!.description;
    }
  }

  @override
  void dispose() {
    _houseNameController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.house != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit House' : 'Add House'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _houseFormScreenKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEditing ? 'Edit House' : 'Add New House',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _houseNameController,
                decoration: const InputDecoration(
                  labelText: 'House Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a house name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (!_houseFormScreenKey.currentState!.validate()) {
                    return;
                  }

                  if (isEditing) {
                    // Update existing house
                    final updatedHouse = House(
                      id: widget.house!.id, // Keep the same ID
                      name: _houseNameController.text,
                      address: _addressController.text,
                      description: _descriptionController.text,
                    );
                    Provider.of<HouseProvider>(
                      context,
                      listen: false,
                    ).updateHouse(widget.house!.id, updatedHouse);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'House updated successfully: ${updatedHouse.name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    // Add new house
                    final house = House(
                      name: _houseNameController.text,
                      address: _addressController.text,
                      description: _descriptionController.text,
                    );
                    Provider.of<HouseProvider>(
                      context,
                      listen: false,
                    ).addHouse(house);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'House added successfully: ${house.name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  isEditing ? 'Update House' : 'Add House',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
