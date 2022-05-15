import 'package:flutter/material.dart';
import 'package:time_saver/Blocks/AppBar.dart';
import 'package:time_saver/Blocks/Category.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

late List<GDPData> _chartData;
class GDPData{
  GDPData(this.categoryTitle, this.gdp, this.colors, this.type);
  final String categoryTitle;
  final int gdp;
  final Color colors;
  final String type;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeSaver',
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
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {

  List<GDPData> getCharData() {
    final List<GDPData> chartData = [
      GDPData('Category 1', 2600, Colors.greenAccent, 'useful'),
      GDPData('Category 2', 1500, Colors.yellow, 'wasted'),
      GDPData('Category 3', 2388, Colors.blue, 'useful'),
      GDPData('Category 4', 16000, Colors.deepPurpleAccent, 'useful'),
      GDPData('Category 5', 18000, Colors.green, 'rest'),
      GDPData('Category 6', 8000, Colors.brown, 'wasted'),
      GDPData('Category 7', 6000, Colors.cyanAccent, 'wasted'),
      GDPData('Category 8', 1000, Colors.orangeAccent, 'rest'),
      GDPData('Category 9', 12000, Colors.teal, 'rest')
    ];
    return chartData;
  }

  @override
  void initState(){
    _chartData = getCharData();
    super.initState();
  }

  int _selectedIndex = 1;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: History',
      style: optionStyle,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Category(
                categoryColor: Color(0xffc82aec),
                categoryTitle: "Category 1",
                categoryTime: 4746,
                categoryIcon: Icon(Icons.star, color: Colors.white)
            ),
            SizedBox(width: 5),
            Category(
                categoryColor: Color(0xff6d35d0),
                categoryTitle: "Category 2",
                categoryTime: 0,
                categoryIcon: Icon(Icons.anchor, color: Colors.white)
            ),
            SizedBox(width: 5),
            Category(
                categoryColor: Color(0xff5c4141),
                categoryTitle: "Category 3",
                categoryTime: 1110,
                categoryIcon: Icon(Icons.add_business_rounded, color: Colors.white)
            ),
            SizedBox(width: 5),
            Category(
                categoryColor: Color(0xffe79818),
                categoryTitle: "Category 4",
                categoryTime: 200,
                categoryIcon: Icon(Icons.vpn_lock, color: Colors.white)
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Category(
                    categoryColor: Color(0xff7049dc),
                    categoryTitle: "Category 5",
                    categoryTime: 0,
                    categoryIcon: Icon(Icons.ac_unit, color: Colors.white)
                ),
                SizedBox(height: 15),
                Category(
                    categoryColor: Color(0xff2aa83a),
                    categoryTitle: "Category 6",
                    categoryTime: 0,
                    categoryIcon: Icon(Icons.account_balance, color: Colors.white)
                ),
              ],
            ),
            Container(
              width: 207,
              height: 207,
              child: Stack(
                children: [
                  SfCircularChart(
                    series: <CircularSeries>[
                      DoughnutSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.categoryTitle,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          pointColorMapper: (GDPData data, _) => data.colors,
                          dataLabelSettings: DataLabelSettings(isVisible: false),
                          innerRadius: '85',
                          radius: '100'
                      ),
                    ],),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Useful: ', style: TextStyle(color: Colors.green, fontSize: 16)),
                                Text('3:25', style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w500)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Wasted: ', style: TextStyle(color: Colors.redAccent, fontSize: 16)),
                                Text('5:14', style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.w500)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Rest: ', style: TextStyle(color: Colors.orangeAccent, fontSize: 16)),
                                Text('2:10', style: TextStyle(color: Colors.orangeAccent, fontSize: 20, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Category(
                    categoryColor: Color(0xff2c88c6),
                    categoryTitle: "Category 7",
                    categoryTime: 0,
                    categoryIcon: Icon(Icons.adb, color: Colors.white)
                ),
                SizedBox(height: 15),
                Category(
                    categoryColor: Color(0xffe22929),
                    categoryTitle: "Category 8",
                    categoryTime: 300,
                    categoryIcon: Icon(Icons.build, color: Colors.white)
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Category(
              categoryColor: Color(0xffe719d2),
              categoryTitle: "Category 9",
              categoryTime: 9542,
              categoryIcon: Icon(Icons.ac_unit, color: Colors.white)
            ),
            SizedBox(width: 5),
            Category(
                categoryColor: Color(0xff3ae785),
                categoryTitle: "Category 10",
                categoryTime: 4299,
                categoryIcon: Icon(Icons.visibility, color: Colors.white)
            ),
            SizedBox(width: 5),
            Category(
                categoryColor: Color(0xffffdc00),
                categoryTitle: "Category 11",
                categoryTime: 3299,
                categoryIcon: Icon(Icons.visibility, color: Colors.white)
            ),
            SizedBox(width: 5),
            Category(
                categoryColor: Color(0xff38955d),
                categoryTitle: "Category 12",
                categoryTime: 0,
                categoryIcon: Icon(Icons.agriculture, color: Colors.white)
            ),
          ],
        ),
      ],
    ),
    Text(
      'Index 2: Overview',
      style: optionStyle,
    ),
  ];

  void _getBottomTap(int index) {
    setState(() {
      _selectedIndex = index;
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
          child: AppBarContent(),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
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
    );
  }
}
