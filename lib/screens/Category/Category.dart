import 'dart:async';
import 'package:flutter/material.dart';
import 'package:models/categories_models.dart';
import 'package:repositories/repository.dart';
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
  List data = [{"category_0": null} ,{"category_1": null}];
  bool loaded = false;

  List<GDPData> getCharData() {
    final List<GDPData> chartData = [
      for(int idx = 1; idx <= data.length; idx++)
        idx == 1 && data[idx]["category_$idx"] == null ?
        GDPData(
            data[idx]["category_$idx"] != null ? data[idx]["category_$idx"]["title"] : "none",
            data[idx]["category_$idx"] != null ? data[idx]["category_$idx"]["time"] : 1,
            data[idx]["category_$idx"] != null ? Color(int.parse("0xff${data[idx]["category_$idx"]["color"]}")) : const Color(0xffc2c2c2),
            data[idx]["category_$idx"] != null ? data[idx]["category_$idx"]["type"] : "none"
        ) :
        GDPData(
            data[idx]["category_$idx"] != null ? data[idx]["category_$idx"]["title"] : "",
            data[idx]["category_$idx"] != null ? data[idx]["category_$idx"]["time"] : 0,
            data[idx]["category_$idx"] != null ? Color(int.parse("0xff${data[idx]["category_$idx"]["color"]}")) : Colors.transparent,
            data[idx]["category_$idx"] != null ? data[idx]["category_$idx"]["type"] : ""
        ),
    ];
    return chartData;
  }

  @override
  void initState(){
    _chartData = loaded ? getCharData() : [
      GDPData("none", 0, Colors.transparent, "useful")
    ];
    super.initState();
  }


  getCategoriesStorage() async {
    var val = await CategoriesRepository().getAllCategories();
    List categoryData = [

        for(int idx = 0; idx < val.length; idx++){
          "category_${idx + 1}":{
            "id": val[val.length - (idx + 1)].id,
            "indexCategory": val[val.length - (idx + 1)].indexCategory,
            "title": val[val.length - (idx + 1)].title,
            "time": val[val.length - (idx + 1)].time,
            "color": val[val.length - (idx + 1)].color,
            "icon": val[val.length - (idx + 1)].icon,
            "type": val[val.length - (idx + 1)].type,
            "min": val[val.length - (idx + 1)].min,
            "max": val[val.length - (idx + 1)].max
          }
        },
        for(int jdx = val.length + 1; jdx <= 20; jdx++){
          "category_$jdx": null,
        }

    ];

    for(var idx = 0; idx < categoryData.length; idx++){
      print("000000000000000000000000000--------------${categoryData[idx]}");
    }

    if(loaded == false){
      setState((){
        data = categoryData;
        loaded = true;
      });
    }
    return categoryData;
  }


  @override
  Widget build(BuildContext context){
    getCategoriesStorage();
    print("+++++++++++++++++${data}");
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    bool limit = false;
    int categoriesLength = 0;
    for(var i = 0; i < data.length; i++){
      if(data[i]["category_$i"] != null){
        categoriesLength++;
      }
    }
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$screenWidth $screenHeight");

    /* Get type of time */
    String timeType(type){
      num timeStamp = 0;
      String time = "00:00";
      var minutes = 0, hours = 0;

      for(var timeIDX = 1; timeIDX <= data.length; timeIDX++){
        if(data[timeIDX]["category_$timeIDX"] != null){
          if(data[timeIDX]["category_$timeIDX"]["type"] == type){
            timeStamp += data[timeIDX]["category_$timeIDX"]["time"];
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
                    color: const Color(0xffdadada),
                    border: Border.all(width: 1, color: const Color(0xffc2c2c2)),
                    borderRadius: BorderRadius.circular(screenWidth * 0.035)
                ),
                child: Icon(Icons.add_rounded, color: Colors.white, size: screenWidth * 0.08),
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
          if(data.length < 4){
            categoriesNum = data.length;
          } else {
            categoriesNum = 4;
          }
          break;
        case 2:
          if(data.length < 6){
            categoriesNum = data.length;
          } else {
            categoriesNum = 6;
          }
          break;
        case 3:
          if(data.length < 8){
            categoriesNum = data.length;
          } else {
            categoriesNum = 8;
          }
          break;
        case 9:
          if(data.length <= 12){
            categoriesNum = data.length;
          } else {
            categoriesNum = 12;
          }
          break;
        case 13:
          if(data.length <= 16){
            categoriesNum = data.length;
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

    return loaded ? Column(
      children: [
        SizedBox(height: screenHeight > 700 ? screenHeight * 0.05 : screenHeight * 0.005),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for(var index = 1; index <= categoryLength(1); index++)
              data[index]["category_$index"] != null ? Category(data: data[index]["category_$index"]) :
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
                  data[index]["category_$index"] != null ? Category(data: data[index]["category_$index"]) :
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
                  data[index]["category_$index"] != null ? Category(data: data[index]["category_$index"]) :
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
                      data[index]["category_$index"] != null ? Category(data: data[index]["category_$index"]) :
                      !limit ? addCategoryButton() : const SizedBox()
                  ],
                )
              else if(categoriesLength == 12 && idx == 12 || categoriesLength == 16 && idx == 16)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    addCategoryButton()
                  ],
                )
          ],
        )
      ],
    ) : const SizedBox();
  }
}
