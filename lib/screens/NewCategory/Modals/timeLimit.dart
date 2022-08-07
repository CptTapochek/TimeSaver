import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class TimeLimitModal extends StatefulWidget{
  const TimeLimitModal(
      BuildContext context, {Key? key, required this.boxTitle, required this.mainColor, required this.inputFunction}
  ) : super(key: key);
  final String boxTitle;
  final Function inputFunction;
  final Color mainColor;

  @override
  State<TimeLimitModal> createState() => TimeLimitState();
}

class TimeLimitState extends State<TimeLimitModal> {
  int hours = 0, minutes = 0;
  Color mainColor = const Color(0xff000000);
  String boxTitle = "";

  @override
  void initState() {
    mainColor = widget.mainColor;
    boxTitle = widget.boxTitle;
    hours; minutes;

    super.initState();
  }

  getIntTimeStamp(){
    int time = 0;
    if(hours > 0){
      time = hours * 60 * 60;
    }
    if(minutes > 0){
      time += minutes * 60;
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      content: Container(
        width: screenWidth * 0.8, height: screenHeight * 0.6,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              boxTitle,
              style: TextStyle(
                color: mainColor,
                fontSize: 18,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            const Divider(height: 0, thickness: 1, color: Color(0xffe0e0e0)),
            Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: screenWidth * 0.28,
                        child: Stack(
                          children: [
                            Positioned(
                                top: screenHeight * 0.175, right: 0,
                                child: Center(
                                  child: Container(
                                    width: screenWidth * 0.125, height: screenHeight * 0.048,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: mainColor),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),
                                )
                            ),
                            Positioned(
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    height: screenHeight * 0.4,
                                    viewportFraction: 0.14,
                                    scrollDirection: Axis.vertical,
                                    onPageChanged: (idx, reason){
                                      setState((){
                                        hours = idx;
                                      });
                                    }
                                ),
                                items: [for(var idx = 0; idx < 25; idx++)idx].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Colors.transparent,
                                        margin: const EdgeInsets.only(right: 8),
                                        child: Text(
                                          i.toString(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(fontSize: screenWidth * 0.066, fontFamily: "Inter"),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                    ),
                    Text(":", style: TextStyle(fontSize: screenWidth * 0.066, fontFamily: "Inter"),),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: screenWidth * 0.28,
                        child: Stack(
                          children: [
                            Positioned(
                                top: screenHeight * 0.175, left: 0,
                                child: Center(
                                  child: Container(
                                    width: screenWidth * 0.125, height: screenHeight * 0.048,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: mainColor),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),
                                )
                            ),
                            Positioned(
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    height: screenHeight * 0.4,
                                    viewportFraction: 0.14,
                                    scrollDirection: Axis.vertical,
                                    onPageChanged: (idx, reason){
                                      setState((){
                                        minutes = idx * 5;
                                      });
                                    }
                                ),
                                items: [for(var idx = 0; idx < 61; idx++)if(idx % 5 == 0)idx].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        color: Colors.transparent,
                                        child: Text(
                                          i.toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: screenWidth * 0.066, fontFamily: "Inter"),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
            ),
            const Divider(height: 0, thickness: 1, color: Color(0xffe0e0e0)),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => mainColor.withOpacity(0.15)),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Inter",
                      color: Color(0xffa1a1a1)
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){
                    String timeTypeLimit = "";
                    if(boxTitle == "Minimal Time"){
                      timeTypeLimit = "min";
                    } else if(boxTitle == "Maximal Time"){
                      timeTypeLimit = "max";
                    }
                    widget.inputFunction(timeTypeLimit, getIntTimeStamp());
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => mainColor.withOpacity(0.15)),
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Inter",
                        color: Color(0xffa1a1a1)
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}