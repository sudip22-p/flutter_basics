import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddHouse extends StatefulWidget {
  const AddHouse({super.key});

  @override
  State<AddHouse> createState() => _AddHouseState();
}

class _AddHouseState extends State<AddHouse> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add House')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _houseNameController,
                decoration: const InputDecoration(labelText: 'House Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a house name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final String houseName = _houseNameController.text;
                    final String location = _locationController.text;
                    final String price = _priceController.text;
                    //unique id based on time and date
                    final String uniqueId = DateTime.now().toIso8601String();

                    final Box box = Hive.box('myBox');
                    box.add({
                      'id': uniqueId,
                      'houseName': houseName,
                      'location': location,
                      'price': price,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('House added successfully')),
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
