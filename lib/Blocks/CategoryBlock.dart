import 'package:flutter/material.dart';

void categoryPress(){
  print('This is the category!');
}

class Category extends StatelessWidget {
  const Category({Key? key,
    required this.categoryColor,
    required this.categoryTitle,
    required this.categoryIcon,
    required this.categoryTime,
  }) : super(key: key);

  final Color categoryColor;
  final String categoryTitle;
  final Icon categoryIcon;
  final int categoryTime;

  @override
  Widget build(BuildContext context) {
    int hours = 0, minutes = 0;
    for(var i = 0; i < categoryTime; i++){
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
        child: TextButton( onPressed: categoryPress,
          child: Column(
            children: [
              SizedBox(
                width: screenWidth * 0.2,
                child: Center(
                    child: Text(
                    categoryTitle,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.036
                    ),
                  )
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: screenWidth * 0.13, height: screenWidth * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: categoryColor,
                ),
                child: categoryIcon,
              ),
              const SizedBox(height: 5),
              Text(
                '${hours < 10 ? '0' : ''}$hours:${minutes < 10 ? '0' : ''}$minutes',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: categoryColor,
                  fontSize: screenWidth * 0.036
                ),
              )
            ],
          ),
        )
    );
  }
}