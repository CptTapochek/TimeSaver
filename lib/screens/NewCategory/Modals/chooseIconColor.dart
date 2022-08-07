import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ChooseIconColor extends StatefulWidget{
  const ChooseIconColor(BuildContext context, {Key? key ,this.colorData, this.mainIcon}) : super(key: key);
  final dynamic colorData;
  final dynamic mainIcon;

  @override
  State<ChooseIconColor> createState() => ChooseIconColorState();
}

class ChooseIconColorState extends State<ChooseIconColor> {
  int hours = 0, minutes = 0;
  Color mainColor = const Color(0xff000000);
  String mainIcon = "";
  String mainColorCategory = "";

  @override
  void initState(){
    hours; minutes;
    mainColor = widget.colorData["pallet"];
    mainColorCategory = widget.colorData["color"];
    mainIcon = widget.mainIcon;

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      content: Container(
        width: screenWidth * 0.9, height: screenHeight * 0.7,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50, height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Center(
                          child: Container(
                            width: 50, height: 50,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(100)
                            ),
                          ),
                        )
                      ),
                      Positioned(
                        child: Center(child: SvgPicture.asset("assets/category-icons/$mainIcon.svg", color: Colors.white, width: 35, height: 35),)
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  "Category Theme",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}