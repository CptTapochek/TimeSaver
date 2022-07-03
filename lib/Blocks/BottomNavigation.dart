import 'package:flutter/material.dart';


class BottomBarNavigation extends StatefulWidget{
  const BottomBarNavigation({Key? key, required this.selectedIndex}) : super(key: key);

  final int selectedIndex;

  @override
  State<StatefulWidget> createState() => BottomBarNavigationState();
}

class BottomBarNavigationState extends State<BottomBarNavigation>{
  var selectedIndex = 1;

  void getBottomTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 14,
      onTap: getBottomTap,
      currentIndex: selectedIndex,
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
    );
  }
}