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

    return Container(
        child: TextButton( onPressed: categoryPress,
          child: Column(
            children: [
              Container(
                width: 80,
                child: Center(child: Text(categoryTitle)),
              ),
              SizedBox(height: 5),
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: categoryColor,
                ),
                child: categoryIcon,
              ),
              SizedBox(height: 5),
              Text('${hours < 10 ? '0' : ''}$hours:${minutes < 10 ? '0' : ''}$minutes',
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
    );
  }
}