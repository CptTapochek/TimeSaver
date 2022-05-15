import 'package:flutter/material.dart';


class BottomBarNavigation{
  const BottomBarNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bottomNavigationBar: BottomNavigationBar(
      selectedFontSize: 14,
      onTap: _getBottomTap,
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.history_rounded),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart_rounded),
          label: 'Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Overview',
        ),
      ],
    ),
  }
}