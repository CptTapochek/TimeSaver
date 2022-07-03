import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_saver/Blocks/CategoryBlock.dart';


late List<GDPData> _chartData;

class GDPData{
  GDPData(this.categoryTitle, this.gdp, this.colors, this.type);

  final String categoryTitle;
  final int gdp;
  final Color colors;
  final String type;
}

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage>{
  final int usefulTime = 0;
  final int wastedTime = 0;
  final int restTime = 0;

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

  @override
  Widget build(BuildContext context){
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${screenWidth} ${screenHeight}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Category(
                categoryColor: Color(0xffc82aec),
                categoryTitle: "Category 1",
                categoryTime: 4746,
                categoryIcon: Icon(Icons.star, color: Colors.white)
            ),
            SizedBox(width: screenWidth * 0.007),
            Category(
                categoryColor: Color(0xff6d35d0),
                categoryTitle: "Category 2",
                categoryTime: 0,
                categoryIcon: Icon(Icons.anchor, color: Colors.white)
            ),
            SizedBox(width: screenWidth * 0.007),
            Category(
                categoryColor: Color(0xff5c4141),
                categoryTitle: "Category 3",
                categoryTime: 1110,
                categoryIcon: Icon(Icons.add_business_rounded, color: Colors.white)
            ),
            SizedBox(width: screenWidth * 0.007),
            Category(
                categoryColor: Color(0xffe79818),
                categoryTitle: "Category 4",
                categoryTime: 200,
                categoryIcon: Icon(Icons.vpn_lock, color: Colors.white)
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.008),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Category(
                    categoryColor: Color(0xff7049dc),
                    categoryTitle: "Category 5",
                    categoryTime: 0,
                    categoryIcon: Icon(Icons.ac_unit, color: Colors.white)
                ),
                SizedBox(height: screenHeight * 0.008),
                Category(
                    categoryColor: Color(0xff2aa83a),
                    categoryTitle: "Category 6",
                    categoryTime: 0,
                    categoryIcon: Icon(Icons.account_balance, color: Colors.white)
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.51,
              height: screenWidth * 0.51,
              child: Stack(
                children: [
                  SfCircularChart(
                    series: <CircularSeries>[
                      DoughnutSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.categoryTitle,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          pointColorMapper: (GDPData data, _) => data.colors,
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                          innerRadius: '${screenWidth * 0.22}',
                          radius: '${screenWidth * 0.264}'
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Time:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.043,
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.014),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Useful: ',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: screenWidth * 0.043
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 1),
                                  child: Text(
                                      '3:25',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: screenWidth * 0.05,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: screenWidth * 0.014),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Wasted: ',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: screenWidth * 0.043
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 1),
                                  child: Text(
                                      '5:14',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: screenWidth * 0.05,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenWidth * 0.014),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Rest: ',
                                    style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: screenWidth * 0.043
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 1),
                                  child: Text(
                                      '2:10',
                                      style: TextStyle(
                                          color: Colors.orangeAccent,
                                          fontSize: screenWidth * 0.05,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                ),
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
                Category(
                    categoryColor: Color(0xff2c88c6),
                    categoryTitle: "Category 7",
                    categoryTime: 0,
                    categoryIcon: Icon(Icons.adb, color: Colors.white)
                ),
                SizedBox(height: screenHeight > 650 ? 15 : 5),
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
        SizedBox(height: screenHeight > 650 ? 15 : 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Category(
                categoryColor: Color(0xffe719d2),
                categoryTitle: "Category 9",
                categoryTime: 9542,
                categoryIcon: Icon(Icons.ac_unit, color: Colors.white)
            ),
            SizedBox(width: screenWidth * 0.007),
            Category(
                categoryColor: Color(0xff3ae785),
                categoryTitle: "Category 10",
                categoryTime: 4299,
                categoryIcon: Icon(Icons.visibility, color: Colors.white)
            ),
            SizedBox(width: screenWidth * 0.007),
            Category(
                categoryColor: Color(0xffffdc00),
                categoryTitle: "Category 11",
                categoryTime: 3299,
                categoryIcon: Icon(Icons.visibility, color: Colors.white)
            ),
            SizedBox(width: screenWidth * 0.007),
            Category(
                categoryColor: Color(0xff38955d),
                categoryTitle: "Category 12",
                categoryTime: 0,
                categoryIcon: Icon(Icons.agriculture, color: Colors.white)
            ),
          ],
        ),
      ],
    );
  }
}
