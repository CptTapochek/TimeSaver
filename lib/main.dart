import 'package:flutter/material.dart';
import 'package:time_saver/Blocks/AppBar.dart';
import 'Blocks/BottomNavigation.dart';
import 'pages/Category.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}


class MainPageState extends State<MainPage> {
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
    CategoryPage(),
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
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
          ),
          child: const AppBarContent(),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
