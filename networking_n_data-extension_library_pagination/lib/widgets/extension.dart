import 'package:flutter/material.dart';

class ExtensionClass extends StatefulWidget {
  const ExtensionClass({super.key});

  @override
  State<ExtensionClass> createState() => _ExtensionClassState();
}

class _ExtensionClassState extends State<ExtensionClass> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Container(
      width: 200,
      height: 80,
      color: Colors.blue,
      child: Center(
        child: Column(
          children: [
            Text(
              'Date time now:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text('OwnStyled date: ${now.toOwnStyledDate()}'),
            Text('Full date: ${now.toFullDate()}'),
          ],
        ),
      ),
    );
  }
}

extension DateTimeFormatting on DateTime {
  String toOwnStyledDate() {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    String month = months[this.month - 1];
    return '$year-$month-$day';
  }

  String toFullDate() {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    String month = months[this.month - 1];
    return '$month $day  $year';
  }
}
