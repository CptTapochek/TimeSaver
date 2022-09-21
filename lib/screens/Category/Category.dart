import 'package:flutter/material.dart';
import 'package:repositories/repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_saver/screens/Category/Blocks/CategoryBlock.dart';
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
  bool reload = false;

  List<GDPData> getCharData() {
    final List<GDPData> chartData = [
      for(int idx = 0; idx <= data.length; idx++)
        idx == 0 && data[idx]["category_${idx + 1}"] == null ?
        GDPData(
            "none", 1, const Color(0xffc2c2c2), "none"
        ) :
        loaded ? GDPData(
            data[idx]["category_${idx + 1}"] != null ? data[idx]["category_${idx + 1}"]["title"] : "",
            data[idx]["category_${idx + 1}"] != null ? data[idx]["category_${idx + 1}"]["time"] : 0,
            data[idx]["category_${idx + 1}"] != null ? Color(int.parse("0xff${data[idx]["category_${idx + 1}"]["color"]}")) : Colors.transparent,
            data[idx]["category_${idx + 1}"] != null ? data[idx]["category_${idx + 1}"]["type"] : ""
        ) : GDPData(
            "none", 1, const Color(0xffc2c2c2), "none"
        ),
    ];

    return chartData;
  }

  @override
  void initState(){
    loaded ? _chartData = [
      GDPData("none", 0, Colors.transparent, "useful")
    ] : _chartData = getCharData();
    super.initState();
  }

  getCategoriesStorage() async {
    var val = await CategoriesRepository().getAllCategories();
    List categoryData = [
        for(int idx = 0; idx < val.length; idx++){
          "category_${idx + 1}":{
            "id": val[idx].id,
            "indexCategory": val[idx].indexCategory,
            "title": val[idx].title,
            "time": val[idx].time,
            "color": val[idx].color,
            "icon": val[idx].icon,
            "type": val[idx].type,
            "min": val[idx].min,
            "max": val[idx].max
          }
        },
        for(int jdx = val.length + 1; jdx <= 20; jdx++){
          "category_$jdx": null,
        }
    ];
    if(loaded == false){
      setState((){
        data = categoryData;
        loaded = true;
      });
    }
    return categoryData;
  }

  resetCategoryStorage() async {
    var res = await CategoriesRepository().getAllCategories();
    List categoryData = [
      for(int idx = 0; idx < res.length; idx++){
        "category_${idx + 1}":{
          "id": res[idx].id,
          "indexCategory": res[idx].indexCategory,
          "title": res[idx].title,
          "time": res[idx].time,
          "color": res[idx].color,
          "icon": res[idx].icon,
          "type": res[idx].type,
          "min": res[idx].min,
          "max": res[idx].max
        }
      },
      for(int jdx = res.length + 1; jdx <= 20; jdx++){
        "category_$jdx": null,
      }
    ];
    if(reload == true){
      setState((){
        data = categoryData;
        reload = false;
      });
    }
  }

  setReloadState() {
    setState((){
      reload = true;
    });
  }


  @override
  Widget build(BuildContext context){
    getCategoriesStorage();
    resetCategoryStorage();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    bool limit = false;
    int categoriesLength = 0;
    for(var i = 0; i < data.length; i++){
      if(data[i]["category_${i + 1}"] != null){
        categoriesLength++;
      }
    }
    print(">>>>>>>>>>>>>>>>>>SCREEN-SIZE>>>>>>>>>>>>>>>>>>$screenWidth $screenHeight");

    /* Get type of time */
    String timeType(type){
      num timeStamp = 0;
      String time = "00:00";
      var minutes = 0, hours = 0;

      for(var timeIDX = 0; timeIDX <= data.length - 1; timeIDX++){
        if(data[timeIDX]["category_${timeIDX + 1}"] != null){
          if(data[timeIDX]["category_${timeIDX + 1}"]["type"] == type){
            timeStamp += data[timeIDX]["category_${timeIDX + 1}"]["time"];
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
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewCategory(index: categoriesLength))),
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
          if(data.length < 3){
            categoriesNum = data.length;
          } else {
            categoriesNum = 3;
          }
          break;
        case 2:
          if(data.length < 5){
            categoriesNum = data.length;
          } else {
            categoriesNum = 5;
          }
          break;
        case 3:
          if(data.length < 7){
            categoriesNum = data.length;
          } else {
            categoriesNum = 7;
          }
          break;
        case 8:
          if(data.length <= 11){
            categoriesNum = data.length;
          } else {
            categoriesNum = 11;
          }
          break;
        case 12:
          if(data.length <= 15){
            categoriesNum = data.length;
          } else {
            categoriesNum = 15;
          }
          break;
        case 16:
          categoriesNum = 19;
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
            for(var index = 0; index <= categoryLength(1); index++)
              data[index]["category_${index + 1}"] != null ?
              Category(data: data[index]["category_${index + 1}"], reloadState: setReloadState) :
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
                for(var index = 4; index <= categoryLength(2); index++)
                  data[index]["category_${index + 1}"] != null ?
                  Category(data: data[index]["category_${index + 1}"], reloadState: setReloadState) :
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
                for(var index = 6; index <= categoryLength(3); index++)
                  data[index]["category_${index + 1}"] != null ?
                  Category(data: data[index]["category_${index + 1}"], reloadState: setReloadState) :
                  !limit ? addCategoryButton() : const SizedBox()
              ],
            ),
          ],
        ),
        SizedBox(height: screenHeight > 700 ? screenHeight * 0.04 : screenHeight * 0.005),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for(var idx = 8; idx <= categoriesLength; idx++)
              if(idx == 8 || idx == 12 || idx == 16)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(var index = idx; index <= categoryLength(idx); index++)
                      data[index]["category_${index + 1}"] != null ?
                      Category(data: data[index]["category_${index + 1}"], reloadState: setReloadState) :
                      !limit ? addCategoryButton() : const SizedBox()
                  ],
                )
              else if(categoriesLength == 12 && idx == 11 || categoriesLength == 16 && idx == 15)
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
