import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BottomSheetAddTime extends StatefulWidget{
  const BottomSheetAddTime(BuildContext context, {Key? key,  required this.data}) : super(key: key);
  final Map<dynamic, dynamic> data;

  @override
  State<BottomSheetAddTime> createState() => AddTimeState();
}

class AddTimeState extends State<BottomSheetAddTime> {
  var data;

  @override
  void initState(){
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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

      if(data["limit"] == true){
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
                  color: data["color"],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(height: 1.4),
                              text: "Range \n",
                              children: [
                                TextSpan(
                                    text: data["limit"] ? "${getTime(data["min"], true)} - ${getTime(data["max"], true)}" : "None",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
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
                              style: const TextStyle(height: 1.4),
                              text: "To category \n",
                              children: [
                                TextSpan(
                                    text: data["title"],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    )
                                )
                              ]
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(right: 15),
                          width: screenWidth * 0.13, height: screenWidth * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                child: Center(
                                  child: SvgPicture.asset("assets/category-icons/${data["icon"]}.svg",
                                      height: screenWidth * 0.07, width: screenWidth * 0.07, color: data["color"]
                                  ),
                                ),
                              )
                            ],
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
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
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Color(0xffe0e0e0),
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