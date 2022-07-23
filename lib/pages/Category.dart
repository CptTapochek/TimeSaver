import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_saver/Blocks/CategoryBlock.dart';

/* Test categories data */
List data = [
  {
    "category_1":{
      "title": "Rutina",
      "time": 2600,
      "color": Color(0xffc82aec),
      "icon": "airdrop",
      "type": "wasted"
    },
    "category_2":{
      "title": "Serial/Films",
      "time": 1500,
      "color": Color(0xff6d35d0),
      "icon": "airplane",
      "type": "rest"
    },
    "category_3":{
      "title": "Work",
      "time": 5212,
      "color": Color(0xff5c4141),
      "icon": "brush",
      "type": "useful"
    },
    "category_4":{
      "title": "Projects",
      "time": 0,
      "color": Color(0xffe79818),
      "icon": "car",
      "type": "useful"
    },
    "category_5":{
      "title": "Extra study",
      "time": 498,
      "color": Color(0xff4997dc),
      "icon": "glass",
      "type": "useful"
    },
    "category_6":{
      "title": "Sleep",
      "time": 9000,
      "color": Color(0xffb90e36),
      "icon": "heart",
      "type": "rest"
    },
    "category_7":{
      "title": "This",
      "time": 4433,
      "color": Color(0xff37af47),
      "icon": "game",
      "type": "useful"
    },
    "category_8": null,
    "category_9": null,
    "category_10": null,
    "category_11": null,
    "category_12": null,
  }
];


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
      for(int idx = 1; idx <= data[0].length; idx++)
        GDPData(
            data[0]["category_$idx"] != null ? data[0]["category_$idx"]["title"] : "",
            data[0]["category_$idx"] != null ? data[0]["category_$idx"]["time"] : 0,
            data[0]["category_$idx"] != null ? data[0]["category_$idx"]["color"] : Colors.transparent,
            data[0]["category_$idx"] != null ? data[0]["category_$idx"]["type"] : ""
        ),
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
    bool limit = false;
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$screenWidth $screenHeight");

    /* Get type of time */
    String timeType(type){
      num timeStamp = 0;
      String time = "00:00";
      var minutes = 0, hours = 0;

      for(var timeIDX = 1; timeIDX <= data[0].length; timeIDX++){
        if(data[0]["category_$timeIDX"] != null){
          if(data[0]["category_$timeIDX"]["type"] == type){
            timeStamp += data[0]["category_$timeIDX"]["time"];
          }
        }
      }
      for(var i = 0; i < timeStamp; i++){
        if(i % 60 == 0){
          minutes++;
          if(minutes % 60 == 0){
            hours++;
            minutes = 0;
          }
        }
      }
      time = '${hours < 10 ? '0' : ''}$hours:${minutes < 10 ? '0' : ''}$minutes';
      return time;
    }

    /* Get the length of category block */
    int categoryLength(blockPart){
      int categoriesNum = 0;
      switch(blockPart){
        case 1:
          if(data[0].length < 4){
            limit = true;
            categoriesNum = data[0].length;
          } else {
            categoriesNum = 4;
          }
          break;
        case 2:
          if(data[0].length < 6){
            limit = true;
            categoriesNum = data[0].length;
          } else {
            categoriesNum = 6;
          }
          break;
        case 3:
          if(data[0].length < 8){
            limit = true;
            categoriesNum = data[0].length;
          } else {
            categoriesNum = 8;
          }
          break;
        case 4:
          if(data[0].length < 12){
            limit = true;
            categoriesNum = data[0].length;
          } else {
            categoriesNum = 12;
          }
          break;
      }
      return categoriesNum;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(var index = 1; index <= categoryLength(1); index++)
              data[0]["category_$index"] != null ? Category(
                categoryColor: data[0]["category_$index"]["color"],
                categoryTitle: data[0]["category_$index"]["title"],
                categoryTime: data[0]["category_$index"]["time"],
                categoryIcon: data[0]["category_$index"]["icon"]
            ) : Container(width: 20,height: 20, color: Colors.black,)
            //SizedBox(width: screenWidth * 0.007),
          ],
        ),
        SizedBox(height: screenHeight > 700 ? screenHeight * 0.008 : screenHeight * 0.008),
        screenHeight > 650 ? SizedBox(height: screenHeight * 0.05,) : const SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var index = 5; index <= categoryLength(2); index++)
                  data[0]["category_$index"] != null ? Category(
                      categoryColor: data[0]["category_$index"]["color"],
                      categoryTitle: data[0]["category_$index"]["title"],
                      categoryTime: data[0]["category_$index"]["time"],
                      categoryIcon: data[0]["category_$index"]["icon"]
                  ) : Container(width: 20,height: 20, color: Colors.black,)
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
                                      timeType("useful"),
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
                                      timeType("wasted"),
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
                                      timeType("rest"),
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
                for(var index = 7; index <= categoryLength(3); index++)
                  data[0]["category_$index"] != null ? Category(
                      categoryColor: data[0]["category_$index"]["color"],
                      categoryTitle: data[0]["category_$index"]["title"],
                      categoryTime: data[0]["category_$index"]["time"],
                      categoryIcon: data[0]["category_$index"]["icon"]
                  ) : TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.2,
                          child: const Text(""),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: screenWidth * 0.12, height: screenWidth * 0.12,
                          decoration: BoxDecoration(
                              color: const Color(0xffc2c2c2),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.08,),
                        ),
                        const SizedBox(height: 5),
                        const Text(""),
                      ],
                    )
                  )
              ],
            ),
          ],
        ),
        SizedBox(height: screenHeight > 650 ? 15 : 5),
        screenHeight > 650 ? SizedBox(height: screenHeight * 0.05,) : const SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Category(
                categoryColor: Color(0xffe719d2),
                categoryTitle: "Category 9",
                categoryTime: 9542,
                categoryIcon: "ship"
            ),
            SizedBox(width: screenWidth * 0.007),
            Category(
                categoryColor: Color(0xff3ae785),
                categoryTitle: "Category 10",
                categoryTime: 4299,
                categoryIcon: "moon"
            ),
            SizedBox(width: screenWidth * 0.007),
            Category(
                categoryColor: Color(0xffffdc00),
                categoryTitle: "Category 11",
                categoryTime: 3299,
                categoryIcon: "messages"
            ),
            SizedBox(width: screenWidth * 0.007),
            Category(
                categoryColor: Color(0xff38955d),
                categoryTitle: "Category 12",
                categoryTime: 0,
                categoryIcon: "monitor"
            ),
          ],
        ),
      ],
    );
  }
}
