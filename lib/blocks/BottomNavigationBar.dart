import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BottomCustomBar extends StatefulWidget{
  const BottomCustomBar(BuildContext context, {Key? key,  required this.selectedIndex, required this.getBottomTap}) : super(key: key);
  final Function getBottomTap;
  final int selectedIndex;

  @override
  State<BottomCustomBar> createState() => BottomCustomBarState();
}

class BottomCustomBarState extends State<BottomCustomBar> {
  int selectedIndex = 1;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: TextButton(
                    onPressed: () {
                      widget.getBottomTap(0);
                      setState((){
                        selectedIndex = 0;
                      });
                    },
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                        padding: MaterialStateProperty.all(const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10))
                    ),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 150),
                      scale: selectedIndex == 0 ? 1.1 : 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/system-icons/clock.svg",
                            width: 24, height: 24, color: const Color(0xffD4418E),
                          ),
                          const Text(
                            "History",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "Inter",
                                color: Color(0xffD4418E)
                            ),
                          ),
                        ],
                      ),
                    )
                )),
                const Expanded(child: Text('')),
                Expanded(child: TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                        padding: MaterialStateProperty.all(const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10))
                    ),
                    onPressed: (){
                      widget.getBottomTap(2);
                      setState((){
                        selectedIndex = 2;
                      });
                    },
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 150),
                      scale: selectedIndex == 2 ? 1.1 : 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/system-icons/chart.svg",
                            width: 23, height: 23, color: const Color(0xff0652C5),
                          ),
                          const Text(
                            "Overview",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "Inter",
                                color: Color(0xff0652C5)
                            ),
                          )
                        ],
                      ),
                    )
                )),
              ],
            ),
          )
      ),
    );
  }
}