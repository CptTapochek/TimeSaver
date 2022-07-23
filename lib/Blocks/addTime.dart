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
    var icon = data["icon"];
    print(">>>>>>>>>>>>>${icon}");

    return Container(
      height: screenHeight * 0.7,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.1,
            color: data["color"],
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white
                  ),
                  child: SvgPicture.asset("assets/category-icons/box.svg", color: Colors.black,)
                )
              ],
            ),
          )
        ],
      )
    );
  }
}