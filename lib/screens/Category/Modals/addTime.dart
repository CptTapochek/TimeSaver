import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:models/categories_models.dart';
import 'package:repositories/repository.dart';
import 'package:time_saver/screens/Category/EditCategory.dart';
import '../../../main.dart';


class BottomSheetAddTime extends StatefulWidget{
  const BottomSheetAddTime(BuildContext context, {Key? key,  required this.data, required this.reloadState}) : super(key: key);
  final Map<dynamic, dynamic> data;
  final Function reloadState;

  @override
  State<BottomSheetAddTime> createState() => AddTimeState();
}

class AddTimeState extends State<BottomSheetAddTime> {
  var data;
  int hours = 0, minutes = 0;

  @override
  void initState(){
    data = widget.data;
    hours; minutes;

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool limit = data["max"] > 0 || data["min"] > 0;

    getTime(time, range){
      int hours = 0, minutes = 0;
      for(var i = 0; i < time; i++){
        if(i % 60 == 0){
          minutes++;
          if(minutes % 60 == 0){
            hours++;
            minutes = 0;
          }
        }
      }
      if(range == true) {
        return "${hours < 10 ? '0' : ''}${hours.toString()}:${minutes < 10 ? '0' : ''}${minutes.toString()}";
      } else {
        return "${hours < 10 ? '0' : ''}${hours.toString()} : ${minutes < 10 ? '0' : ''}${minutes.toString()}";
      }
    }

    getScreenLoadingWidth(){
      double width = 0.0;

      if(limit == true){
        if(data["min"] > 0){
          if(data["time"] <= data["max"]){
            width = screenWidth * data["time"]/data["min"];
          }else{
            width = screenWidth * data["time"]/data["max"];
          }
        }else{
          width = screenWidth * data["time"]/data["max"];
        }
      }else{
        width = screenWidth;
      }
      return width;
    }

    int getTimeInSeconds(){
      int seconds = data["time"], min = 0;
      if(hours > 0){
        min = hours * 60;
      }
      if(min > 0 || minutes > 0){
        seconds += (min + minutes) * 60;
      }

      return seconds;
    }


    return Container(
      height: screenHeight * 0.7,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.1,
                  color: Color(int.parse("0xff${data["color"]}")),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(height: 1.4, fontFamily: "Inter"),
                              text: "Range \n",
                              children: [
                                TextSpan(
                                    text: limit ? "${getTime(data["min"], true)} - ${getTime(data["max"], true)}" : "None",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Inter"
                                    )
                                )
                              ]
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: data["title"].length > 12 ? screenWidth * 0.35 :
                        data["title"].length > 9 ? screenWidth * 0.3 : screenWidth * 0.23,
                        margin: const EdgeInsets.only(right: 5),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              style: const TextStyle(height: 1.4, fontFamily: "Inter"),
                              text: "To category \n",
                              children: [
                                TextSpan(
                                    text: data["title"],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Inter"
                                    )
                                )
                              ]
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditCategory(data: data))),
                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                            padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero)
                        ),
                        child: Container(
                            margin: const EdgeInsets.only(right: 15),
                            width: screenWidth * 0.13, height: screenWidth * 0.13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(screenWidth * 0.035),
                                color: Colors.white
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Center(
                                    child: SvgPicture.asset("assets/category-icons/${data["icon"]}.svg",
                                        height: screenWidth * 0.07, width: screenWidth * 0.07, color: Color(int.parse("0xff${data["color"]}"))
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                  width: screenWidth,
                  child: Center(
                    child: Text(
                      getTime(data["time"], false),
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Inter",
                          color: Color(0xffC81343)
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0, thickness: 1, color: Color(0xffe0e0e0)),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: screenWidth * 0.416,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: screenHeight * 0.089, right: 0,
                                  child: Center(
                                    child: Container(
                                      width: screenWidth * 0.125, height: screenHeight * 0.048,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2, color: const Color(0xffC81343)),
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                    ),
                                  )
                              ),
                              Positioned(
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    height: screenHeight * 0.227,
                                    viewportFraction: 0.22,
                                    scrollDirection: Axis.vertical,
                                    onPageChanged: (idx, reason){
                                      setState((){
                                        hours = idx;
                                      });
                                    }
                                  ),
                                  items: [for(var idx = 0; idx < 25; idx++)idx].map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          color: Colors.transparent,
                                          margin: const EdgeInsets.only(right: 8),
                                          child: Text(
                                            i.toString(),
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontSize: screenWidth * 0.066, fontFamily: "Inter"),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          )
                      ),
                      Text(":", style: TextStyle(fontSize: screenWidth * 0.066, fontFamily: "Inter"),),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: screenWidth * 0.416,
                        child: Stack(
                          children: [
                            Positioned(
                              top: screenHeight * 0.089, left: 0,
                              child: Center(
                                child: Container(
                                  width: screenWidth * 0.125, height: screenHeight * 0.048,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2, color: const Color(0xffC81343)),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              )
                            ),
                            Positioned(
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: screenHeight * 0.227,
                                  viewportFraction: 0.22,
                                  scrollDirection: Axis.vertical,
                                    onPageChanged: (idx, reason){
                                      setState((){
                                        minutes = idx;
                                      });
                                    }
                                ),
                                items: [for(var idx = 0; idx < 60; idx++)idx].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        color: Colors.transparent,
                                        child: Text(
                                          i.toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: screenWidth * 0.066, fontFamily: "Inter"),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 1),
                const Divider(height: 0, thickness: 1, color: Color(0xffe0e0e0)),
                const SizedBox(height: 5),
                TextButton(
                  style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                  onPressed: (){
                    CategoriesRepository().editCategory(CategoriesModel(
                        id: data["id"],
                        indexCategory: data["indexCategory"],
                        title: data["title"],
                        time: getTimeInSeconds(),
                        color: data["color"],
                        icon: data["icon"],
                        type: data["type"],
                        min: data["min"],
                        max: data["max"])
                    );
                    widget.reloadState();
                    Navigator.pop(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const MainPage())
                    // );
                  },
                  child: SizedBox(
                    height: screenHeight * 0.057, width: screenWidth * 0.5,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color(int.parse("0xff${data["color"]}"))
                            ),
                          )
                        ),
                        Positioned(
                          child: Center(
                            child: Icon(Icons.add_rounded, size: screenWidth * 0.083, color: Colors.white),
                          )
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 10, width: getScreenLoadingWidth(),
              color: Colors.green,
            ),
          )
        ],
      )
    );
  }
}