import 'package:flutter/material.dart';
import 'package:crud_on_house_list/utils/house.dart';
import 'package:crud_on_house_list/widgets/house_actions.dart';

class HouseCard extends StatefulWidget {
  final House house;
  const HouseCard({super.key, required this.house});

  @override
  State<HouseCard> createState() => _HouseCardState();
}

class _HouseCardState extends State<HouseCard> {
  @override
  Widget build(BuildContext context) {
    final house = widget.house;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HouseContent(house: house),
                HouseActions(house: house),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HouseContent extends StatelessWidget {
  const HouseContent({super.key, required this.house});

  final House house;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            house.name[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 12),
        // houseDetail(context),
        HouseDetailWidget(house: house),
      ],
    );
  }
}

class HouseDetailWidget extends StatelessWidget {
  const HouseDetailWidget({super.key, required this.house});

  final House house;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            house.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            house.address,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            house.description,
            maxLines: 1,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
