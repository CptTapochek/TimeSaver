import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_saver/screens/Category/Blocks/CategoryBlock.dart';
import 'package:time_saver/Data/data.dart';
import 'package:time_saver/screens/NewCategory/NewCategory.dart';


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
  int usefulTime = 0;
  int wastedTime = 0;
  int restTime = 0;
  List data = getCategoriesData();


  List<GDPData> getCharData() {
    final List<GDPData> chartData = [
      for(int idx = 1; idx <= data[0].length; idx++)
        idx == 1 && data[0]["category_$idx"] == null ?
        GDPData(
            data[0]["category_$idx"] != null ? data[0]["category_$idx"]["title"] : "none",
            data[0]["category_$idx"] != null ? data[0]["category_$idx"]["time"] : 1,
            data[0]["category_$idx"] != null ? data[0]["category_$idx"]["color"] : const Color(0xffc2c2c2),
            data[0]["category_$idx"] != null ? data[0]["category_$idx"]["type"] : "none"
        ) :
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
    int categoriesLength = 0;
    for(var i = 0; i < data[0].length; i++){
      if(data[0]["category_$i"] != null){
        categoriesLength++;
      }
    }
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

    addCategoryButton(){
      setState((){
        limit = true;
      });
      return TextButton(
          style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewCategory(index: categoriesLength + 1)));
          },
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
      );
    }

    /* Get the length of category block */
    int categoryLength(blockPart){
      int categoriesNum = 0;

      switch(blockPart){
        case 1:
          if(data[0].length < 4){
            categoriesNum = data[0].length;
          } else {
            categoriesNum = 4;
          }
          break;
        case 2:
          if(data[0].length < 6){
            categoriesNum = data[0].length;
          } else {
            categoriesNum = 6;
          }
          break;
        case 3:
          if(data[0].length < 8){
            categoriesNum = data[0].length;
          } else {
            categoriesNum = 8;
          }
          break;
        case 9:
          if(data[0].length <= 12){
            categoriesNum = data[0].length;
          } else {
            categoriesNum = 12;
          }
          break;
        case 13:
          if(data[0].length <= 16){
            categoriesNum = data[0].length;
          } else {
            categoriesNum = 16;
          }
          break;
        case 17:
          categoriesNum = 20;
          break;
      }
      return categoriesNum;
    }

    return Column(
      children: [
        SizedBox(height: screenHeight > 700 ? screenHeight * 0.05 : screenHeight * 0.005),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for(var index = 1; index <= categoryLength(1); index++)
              data[0]["category_$index"] != null ? Category(data: data[0]["category_$index"]) :
              !limit ? addCategoryButton() : const SizedBox()
          ],
        ),
        SizedBox(height: screenHeight > 700 ? screenHeight * 0.04 : screenHeight * 0.005),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                for(var index = 5; index <= categoryLength(2); index++)
                  data[0]["category_$index"] != null ? Category(data: data[0]["category_$index"]) :
                  !limit ? addCategoryButton() : const SizedBox()
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight > 700 ? screenHeight * 0.0387 : screenHeight * 0.0187),
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
              child: Stack(
                children: [
                  SfCircularChart(
                    series: <CircularSeries>[
                      DoughnutSeries<GDPData, String>(
                          dataSource: _chartData,
                          animationDuration: 700,
                          xValueMapper: (GDPData data, _) => data.categoryTitle,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          pointColorMapper: (GDPData data, _) => data.colors,
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                          innerRadius: '${screenWidth * 0.207}',
                          radius: '${screenWidth * 0.24}'
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
                                fontFamily: "Inter",
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
                                      fontFamily: "Inter",
                                      fontSize: screenWidth * 0.043
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 1),
                                  child: Text(
                                      timeType("useful"),
                                      style: TextStyle(
                                          fontFamily: "Inter",
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
                                        fontFamily: "Inter",
                                        color: Colors.redAccent,
                                        fontSize: screenWidth * 0.043
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 1),
                                  child: Text(
                                      timeType("wasted"),
                                      style: TextStyle(
                                          fontFamily: "Inter",
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
                                        fontFamily: "Inter",
                                        color: Colors.orangeAccent,
                                        fontSize: screenWidth * 0.043
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 1),
                                  child: Text(
                                      timeType("rest"),
                                      style: TextStyle(
                                          fontFamily: "Inter",
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
            categoriesLength == 4 || categoriesLength == 5 ? SizedBox(width: screenWidth * 0.24, height: screenWidth * 0.285) :
            Column(
              children: [
                for(var index = 7; index <= categoryLength(3); index++)
                  data[0]["category_$index"] != null ? Category(data: data[0]["category_$index"]) :
                  !limit ? addCategoryButton() : const SizedBox()
              ],
            ),
          ],
        ),
        SizedBox(height: screenHeight > 700 ? screenHeight * 0.04 : screenHeight * 0.005),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for(var idx = 9; idx <= categoriesLength; idx++)
              if(idx == 9 || idx == 13 || idx == 17)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(var index = idx; index <= categoryLength(idx); index++)
                      data[0]["category_$index"] != null ? Category(data: data[0]["category_$index"]) :
                      !limit ? addCategoryButton() : const SizedBox()
                  ],
                )
          ],
        )
      ],
    );
  }
}
