import 'package:flutter/material.dart';
import 'package:networking_n_data/data/item_data.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  List<String> paginatedData = []; // Stores loaded items
  int page = 0; // Keeps track of the current page
  bool isLoading = false; // Prevents multiple calls
  final int pageSize = 6; // Items per page
  final ScrollController _scrollController =
      ScrollController(); // to track the scroll position

  void loadMore() {
    setState(() => isLoading = true);

    Future.delayed(Duration(milliseconds: 500), () {
      int start = page * pageSize;
      int end = start + pageSize;
      if (start < itemDatabase.length) {
        List<String> nextPageItems = itemDatabase.sublist(
          start,
          end > itemDatabase.length ? itemDatabase.length : end,
        );

        setState(() {
          paginatedData.addAll(nextPageItems);
          page++;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false); // No more data
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadMore(); // Load first page

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        if (!isLoading) {
          loadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 350,
      child: Scrollbar(
        thumbVisibility: true,
        radius: const Radius.circular(10),
        thickness: 9,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: paginatedData.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == paginatedData.length) {
              return Center(child: CircularProgressIndicator());
            }
            return ListTile(title: Text(paginatedData[index]));
          },
        ),
      ),
    );
  }
}
