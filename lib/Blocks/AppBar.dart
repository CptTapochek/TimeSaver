import 'package:flutter/material.dart';

void editCategories(){
  print('Edit categories');
}

final ButtonStyle elevatedBtnStyle = ElevatedButton.styleFrom(
  elevation: 0.0,
  shadowColor: Colors.transparent,
);

class AppBarContent extends StatelessWidget {
  const AppBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              IconButton(onPressed: editCategories, icon: Icon(Icons.menu), color: Colors.white),
              IconButton(onPressed: editCategories, icon: Icon(Icons.edit), color: Colors.white),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(onPressed: editCategories, icon: Icon(Icons.arrow_back_ios), color: Colors.white),
              ElevatedButton(onPressed: editCategories, style: elevatedBtnStyle,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.5),
                          //border: Border.all(width: 1, color: Colors.white),
                          color: Colors.white,
                        ),
                        child: Text('30', style: TextStyle(
                            fontSize: 16, color: Colors.deepPurple
                        )),
                      ),
                      SizedBox(width: 5),
                      Text('APRIL', style: TextStyle(
                          fontSize: 17
                      )),
                      SizedBox(width: 5),
                      Text('2022', style: TextStyle(
                          fontSize: 17
                      )),
                      Icon(Icons.arrow_drop_down_sharp, size: 25)
                    ],
                  )),
              IconButton(onPressed: editCategories, icon: Icon(Icons.arrow_forward_ios), color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}