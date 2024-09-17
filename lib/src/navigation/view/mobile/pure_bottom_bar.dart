import 'package:flutter/material.dart';

class PureBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<String> labels;
  final List<IconData> icons;

  const PureBottomBar({
    super.key,
    this.onTap,
    required this.currentIndex,
    required this.labels,
    required this.icons,
  });


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      elevation: 3,
      // fixedColor: themeColor.activeColor,
      type: BottomNavigationBarType.fixed,
      iconSize: 22,
      selectedItemColor: Theme
          .of(context)
          .primaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      // backgroundColor: themeColor.itemColor,
      items: labels
          .asMap()
          .keys
          .map((index) =>
          BottomNavigationBarItem(label: labels[index], icon: Icon(icons[index])))
          .toList(),
    );
  }
}
