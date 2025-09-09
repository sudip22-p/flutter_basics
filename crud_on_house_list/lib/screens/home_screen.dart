import 'package:crud_on_house_list/provider/house_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_on_house_list/screens/house_form_screen.dart';
import 'package:crud_on_house_list/widgets/house_card.dart';
import 'package:crud_on_house_list/widgets/house_details_popup.dart';
import 'package:crud_on_house_list/screens/wishlist_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House List CRUD'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.pink),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WishlistScreen()),
              );
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          children: [
            _HeaderSection(),
            SizedBox(height: 16),
            Expanded(child: _HouseListSection()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HouseFormScreen()),
          );
        },
        tooltip: 'Add House',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Houses',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class _HouseListSection extends StatelessWidget {
  const _HouseListSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<HouseProvider>(
      builder: (context, houseProvider, child) {
        if (houseProvider.houses.isEmpty) {
          return const _EmptyStateWidget();
        }
        return ListView.builder(
          itemCount: houseProvider.houses.length,
          itemBuilder: (context, index) {
            final house = houseProvider.houses[index];
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return HouseDetailsPopup(
                      name: house.name,
                      address: house.address,
                      description: house.description,
                    );
                  },
                );
              },
              child: HouseCard(house: house),
            );
          },
        );
      },
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No houses yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first house',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
