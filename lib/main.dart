import 'package:flutter/material.dart';
import 'package:time_saver/Blocks/AppBar.dart';
import 'pages/Category.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}


class MainPageState extends State<MainPage> {
  Color mainColor = const Color(0xff5c6ac0);

  @override
  void initState(){
    super.initState();
  }

  int selectedIndex = 1;
  static final List<Widget> _widgetOptions = <Widget>[
    const Text(
      'Index 0: History',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    const SingleChildScrollView(
      child: CategoryPage()
    ),
    const Text(
      'Index 2: Overview',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
  ];

  void getBottomTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
          ),
          child: AppBarContent(mainColor: mainColor),
        ),
      ),
      body: _widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: BottomNavigationBar(
          selectedItemColor: mainColor,
          unselectedItemColor: const Color(0xffa8a8a8),
          selectedFontSize: 14,
          unselectedLabelStyle: const TextStyle(fontFamily: "Inter"),
          selectedLabelStyle: const TextStyle(fontFamily: "Inter"),
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
        ),
      )
    );
  }
}
