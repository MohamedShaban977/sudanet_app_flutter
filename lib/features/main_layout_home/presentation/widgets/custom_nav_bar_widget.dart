import 'package:flutter/material.dart';

import '../../../../widgets/bottom_navy_bar.dart';

class CustomNavBarWidget extends StatelessWidget {
  final Function(int index) onItemSelected ;
  final int currentIndex;
  final List<BottomNavyBarItem> items;
  const CustomNavBarWidget({Key? key, required this.onItemSelected, required this.currentIndex, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BottomNavyBar(
      selectedIndex: currentIndex,
      showElevation: true,
      spreadRadius: 5.0,
      blurRadius: 5.0,
      flexIndex: 1,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10.0),
        topLeft: Radius.circular(10.0),
      ),

      onItemSelected: (index) => onItemSelected(index),
      items: items,
    );
  }
}
