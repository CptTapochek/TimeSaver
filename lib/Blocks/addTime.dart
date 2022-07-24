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

    return Container(
      height: screenHeight * 0.7,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.1,
            color: data["color"],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      height: 1.4
                    ),
                    text: "To category \n",
                    children: [
                      TextSpan(
                        text: data["title"],
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ]
                  ),
                ),
                Container(
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
          )
        ],
      )
    );
  }
}