import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase extends StatefulWidget {
  const HiveDatabase({super.key});

  @override
  State<HiveDatabase> createState() => _HiveDatabaseState();
}

class _HiveDatabaseState extends State<HiveDatabase> {
  var houseBox = Hive.box('myBox');
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _housenameController = TextEditingController();
  final TextEditingController _houseaddressController = TextEditingController();
  final TextEditingController _housepriceController = TextEditingController();

  @override
  void dispose() {
    _housenameController.dispose();
    _houseaddressController.dispose();
    _housepriceController.dispose();
    super.dispose();
  }

  void addHouse() {
    if (_formkey.currentState!.validate()) {
      // Save the data to Hive
      houseBox.put('housename', _housenameController.text);
      houseBox.put('houseaddress', _houseaddressController.text);
      houseBox.put('houseprice', _housepriceController.text);
    }
  }

  //delete house
  void deleteHouse() {
    houseBox.delete('housename');
    houseBox.delete('houseaddress');
    houseBox.delete('houseprice');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('House data deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive Database Example')),
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _housenameController,
                decoration: InputDecoration(labelText: 'House Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a house name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _houseaddressController,
                decoration: InputDecoration(labelText: 'House Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a house address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _housepriceController,
                decoration: InputDecoration(labelText: 'House Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a house price';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    // Save the data to Hive
                    houseBox.put('housename', _housenameController.text);
                    houseBox.put('houseaddress', _houseaddressController.text);
                    houseBox.put('houseprice', _housepriceController.text);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Data Saved')));
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to perform when the button is pressed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Floating Action Button Pressed')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
