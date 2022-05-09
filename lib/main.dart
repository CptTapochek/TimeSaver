import 'package:flutter/material.dart';
import 'package:time_saver/Blocks/AppBar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

late List<GDPData> _chartData;
class GDPData{
  GDPData(this.continent, this.gdp, this.colors);
  final String continent;
  final int gdp;
  final Color colors;
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

  List<GDPData> getCharData(){
    final List<GDPData> chartData = [
      GDPData('Oceania', 2600, Colors.greenAccent),
      GDPData('Africa', 1500, Colors.yellow),
      GDPData('S America', 2388, Colors.blue),
      GDPData('Europe', 23000, Colors.deepPurpleAccent),
      GDPData('N America', 25000, Colors.green),
      GDPData('Asia', 28000, Colors.pinkAccent)
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
          children: [
            Container(
                child: Column(
                  children: [
                    Text('Category'),
                    SizedBox(height: 10),
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.purpleAccent,
                      ),
                      child: Icon(Icons.star, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    Text('00:00', style: TextStyle(fontWeight: FontWeight.w600),)
                  ],
                )
            ),
            SizedBox(width: 40),
            Container(
                child: Column(
                  children: [
                    Text('Category'),
                    SizedBox(height: 10),
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.deepPurple,
                      ),
                      child: Icon(Icons.anchor, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    Text('00:00', style: TextStyle(fontWeight: FontWeight.w600),)
                  ],
                )
            ),
            SizedBox(width: 40),
            Container(
                child: Column(
                  children: [
                    Text('Category'),
                    SizedBox(height: 10),
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.brown,
                      ),
                      child: Icon(Icons.add_business_rounded, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    Text('08:00', style: TextStyle(fontWeight: FontWeight.w600),)
                  ],
                )
            ),
            SizedBox(width: 40),
            Container(
                child: Column(
                  children: [
                    Text('Category'),
                    SizedBox(height: 10),
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.deepOrangeAccent,
                      ),
                      child: Icon(Icons.vpn_lock, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    Text('00:14', style: TextStyle(fontWeight: FontWeight.w600),)
                  ],
                )
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Column(
                      children: [
                        Text('Category'),
                        SizedBox(height: 10),
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.deepPurple,
                          ),
                          child: Icon(Icons.ac_unit, color: Colors.white,),
                        ),
                        SizedBox(height: 5),
                        Text('01:10', style: TextStyle(fontWeight: FontWeight.w600),)
                      ],
                    )
                ),
                SizedBox(height: 25),
                Container(
                    child: Column(
                      children: [
                        Text('Category'),
                        SizedBox(height: 10),
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.green,
                          ),
                          child: Icon(Icons.account_balance, color: Colors.white,),
                        ),
                        SizedBox(height: 5),
                        Text('00:45', style: TextStyle(fontWeight: FontWeight.w600),)
                      ],
                    )
                )
              ],
            ),
            Container(
              width: 240,
              height: 240,
              child: Stack(
                children: [
                  SfCircularChart(
                    series: <CircularSeries>[
                      DoughnutSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.continent,
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
              children: [
                Container(
                    child: Column(
                      children: [
                        Text('Category'),
                        SizedBox(height: 10),
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blue,
                          ),
                          child: Icon(Icons.adb, color: Colors.white,),
                        ),
                        SizedBox(height: 5),
                        Text('00:25', style: TextStyle(fontWeight: FontWeight.w600),)
                      ],
                    )
                ),
                SizedBox(height: 25),
                Container(
                    child: Column(
                      children: [
                        Text('Category'),
                        SizedBox(height: 10),
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.red,
                          ),
                          child: Icon(Icons.build, color: Colors.white,),
                        ),
                        SizedBox(height: 5),
                        Text('00:20', style: TextStyle(fontWeight: FontWeight.w600),)
                      ],
                    )
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Column(
                  children: [
                    Text('Category'),
                    SizedBox(height: 10),
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.pinkAccent,
                      ),
                      child: Icon(Icons.ac_unit, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    Text('03:20', style: TextStyle(fontWeight: FontWeight.w600),)
                  ],
                )
            ),
            SizedBox(width: 40),
            Container(
                child: Column(
                  children: [
                    Text('Category'),
                    SizedBox(height: 10),
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.greenAccent,
                      ),
                      child: Icon(Icons.visibility, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    Text('00:18', style: TextStyle(fontWeight: FontWeight.w600),)
                  ],
                )
            ),
            SizedBox(width: 40),
            Container(
                child: Column(
                  children: [
                    Text('Category'),
                    SizedBox(height: 10),
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.purpleAccent,
                      ),
                      child: Icon(Icons.apartment_outlined, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    Text('00:25', style: TextStyle(fontWeight: FontWeight.w600),)
                  ],
                )
            ),
            SizedBox(width: 40),
            Container(
                child: Column(
                  children: [
                    Text('Category'),
                    SizedBox(height: 10),
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.yellow,
                      ),
                      child: Icon(Icons.agriculture_sharp, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    Text('02:05', style: TextStyle(fontWeight: FontWeight.w600),)
                  ],
                )
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
