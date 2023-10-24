import 'package:algorithm/algorithm.dart';
import 'package:flutter/material.dart';

class DeskSortPage extends StatelessWidget{
  const DeskSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      endDrawer: Drawer(
        child: SortSettings(),
      ),
      body: Column(
        children: [
          DeskSortBar(),
          Expanded(child: SortPaper()),
        ],
      ),
    );
  }
}