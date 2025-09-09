import 'package:flutter/material.dart';

class HouseDetailsPopup extends StatelessWidget {
  final String address;
  final String name;
  final String description;

  const HouseDetailsPopup({
    super.key,
    required this.address,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('House Details'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              children: [
                //add name and location with proper icon and styling
                Icon(Icons.home, color: Colors.black),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
