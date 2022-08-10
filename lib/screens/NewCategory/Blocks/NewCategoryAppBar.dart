import 'package:flutter/material.dart';


class AppBarContent extends StatefulWidget {
  const AppBarContent({Key? key, required this.mainColor, required this.addNewCategory}) : super(key: key);
  final Color mainColor;
  final Function addNewCategory;

  @override
  State<AppBarContent> createState() => AppBarContentState();
}

class AppBarContentState extends State<AppBarContent> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = widget.mainColor;

    return SafeArea(
      top: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    splashColor: Colors.transparent,
                    icon: const Icon(Icons.close_outlined, size: 30,),
                    color: Colors.white
                ),
                const Text(
                  'New category',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter"
                  ),
                ),
                IconButton(
                    onPressed: () => widget.addNewCategory(),
                    icon: const Icon(Icons.check_outlined, size: 30,),
                    color: Colors.white
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}