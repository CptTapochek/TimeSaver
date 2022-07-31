import 'package:flutter/material.dart';


class AppBarContent extends StatefulWidget {
  const AppBarContent({Key? key, required this.mainColor}) : super(key: key);
  final Color mainColor;

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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
                    icon: Icon(Icons.close_outlined, size: 30,),
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.check_outlined, size: 30,),
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