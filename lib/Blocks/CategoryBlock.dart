import 'package:flutter/material.dart';
import 'package:time_saver/Blocks/addTime.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Category extends StatefulWidget {
  const Category({Key? key,
    required this.categoryColor,
    required this.categoryTitle,
    required this.categoryIcon,
    required this.categoryTime,
  }) : super(key: key);

  final Color categoryColor;
  final String categoryTitle;
  final String categoryIcon;
  final int categoryTime;

  @override
  State<Category> createState() => CategoryState();
}

class CategoryState extends State<Category> {
  var data = {};

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = {
      "color": widget.categoryColor,
      "title": widget.categoryTitle,
      "icon": widget.categoryIcon,
      "time": widget.categoryTime
    };

    int hours = 0, minutes = 0;
    for(var i = 0; i < data["time"]; i++){
      if(i % 60 == 0){
        minutes++;
        if(minutes % 60 == 0){
          hours++;
          minutes = 0;
        }
      }
    }

    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
        child: TextButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context){
                  return BottomSheetAddTime(context, data: data,);
                }
            );
          },
          child: Column(
            children: [
              SizedBox(
                width: screenWidth * 0.2,
                child: Center(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: data["title"],
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth * 0.036
                        ),
                      ),
                    )
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: screenWidth * 0.13, height: screenWidth * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: data["color"],
                ),
                child: SvgPicture.asset("assets/category-icons/${data["icon"]}.svg", height: 10, width: 10,),
              ),
              const SizedBox(height: 5),
              Text(
                '${hours < 10 ? '0' : ''}$hours:${minutes < 10 ? '0' : ''}$minutes',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: data["color"],
                  fontSize: screenWidth * 0.036
                ),
              )
            ],
          ),
        )
    );
  }
}