import 'package:flutter/material.dart';

class BottomSheetAddTime extends StatefulWidget{
  const BottomSheetAddTime(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<BottomSheetAddTime> createState() => AddTimeState();
}

class AddTimeState extends State<BottomSheetAddTime> {

  @override
  void initState(){

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.55,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.amber
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}