import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_saver/Data/iconsColors.dart';


class ChooseIconColor extends StatefulWidget{
  const ChooseIconColor(BuildContext context, {Key? key ,this.colorData, this.mainIcon, required this.changeState}) : super(key: key);
  final dynamic colorData;
  final dynamic mainIcon;
  final Function changeState;

  @override
  State<ChooseIconColor> createState() => ChooseIconColorState();
}

class ChooseIconColorState extends State<ChooseIconColor> {
  int hours = 0, minutes = 0;
  Color mainColor = const Color(0xff000000);
  String mainIcon = "";
  String mainColorCategory = "";
  List iconsList = getListOfIcons();
  List colorsList = getListOfColors();
  bool colorSecondScreen = false;
  int colorPallet = 0;

  @override
  void initState(){
    hours; minutes;
    mainColor = widget.colorData["pallet"];
    mainColorCategory = widget.colorData["color"];
    mainIcon = widget.mainIcon;

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Container(
        width: screenWidth * 0.9, height: screenHeight * 0.8,
        color: Colors.white,
        child: MaterialApp(
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                bottom: TabBar(
                  tabs: const [
                    Tab(text: "ICON",),
                    Tab(text: "COLOR"),
                  ],
                  indicatorWeight: 3,
                  indicatorColor: /*Color(0xff676767)*/ mainColor,
                  labelColor: /*Color(0xff676767)*/ mainColor,
                  unselectedLabelColor: const Color(0xffbebebe),
                  labelStyle: const TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w500, fontSize: 14),
                ),

                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 50, height: 50,
                      child: Stack(
                        children: [
                          Positioned(
                              child: Center(
                                child: Container(
                                  width: 50, height: 50,
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                              )
                          ),
                          Positioned(
                            child: Center(
                              child: SvgPicture.asset(
                                  "assets/category-icons/$mainIcon.svg",
                                  color: Colors.white, width: 28, height: 28
                              )
                            )
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "Category Theme",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff1c1c1c)
                      ),
                    )
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  /* ICON TAB */
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.5, width: screenWidth * 0.8,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              for(var idx = 0; idx < iconsList.length; idx++)
                                if(idx % 4 == 0)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for(var jdx = idx; jdx < idx + 4; jdx++)
                                        TextButton(
                                          onPressed: (){
                                            setState((){
                                              mainIcon = iconsList[jdx];
                                            });
                                          },
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(left: screenWidth * 0.013),
                                            width: 50, height: 50,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Center(
                                                    child: Container(
                                                      width: 50, height: 50,
                                                      decoration: BoxDecoration(
                                                        color: iconsList[jdx] == mainIcon ? const Color(0xff757575) : const Color(0xfff5f5f5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: iconsList[jdx] == mainIcon ? Colors.transparent : const Color(0xffd7d7d7)
                                                        ),
                                                        borderRadius: BorderRadius.circular(100)
                                                      ),
                                                    ),
                                                  )
                                                ),
                                                Positioned(
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                          "assets/category-icons/${iconsList[jdx]}.svg",
                                                          color: iconsList[jdx] == mainIcon ? Colors.white : const Color(0xff757575),
                                                          width: 28, height: 28
                                                      ),
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                    ],
                                  )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xff8a8a8a).withOpacity(0.25)),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff676767),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                widget.changeState(mainColor, mainIcon);
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xff8a8a8a).withOpacity(0.25)),
                              ),
                              child: const Text(
                                "Done",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff676767),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  /* COLOR TAB */
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.5, width: screenWidth * 0.8,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              for(var idx = 0; !colorSecondScreen ? idx < colorsList.length : idx < colorsList[colorPallet].length; idx++)
                                if(idx % 4 == 0)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for(var jdx = idx; jdx < idx + 4; jdx++)
                                        if(!colorSecondScreen ? jdx < colorsList.length : jdx < colorsList[colorPallet].length)
                                          TextButton(
                                            onPressed: (){
                                              setState((){
                                                if(colorSecondScreen){
                                                  mainColor = colorsList[colorPallet][jdx];
                                                }else{
                                                  colorSecondScreen = true;
                                                  colorPallet = jdx;
                                                }
                                              });
                                            },
                                            style: ButtonStyle(
                                              overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(left: screenWidth * 0.013),
                                              width: 50, height: 50,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    child: Container(
                                                      width: 50, height: 50,
                                                      decoration: BoxDecoration(
                                                          color: colorSecondScreen ? colorsList[colorPallet][jdx] : colorsList[jdx][0],
                                                          borderRadius: BorderRadius.circular(100)
                                                      ),
                                                    ),
                                                  ),
                                                  if(!colorSecondScreen)
                                                    colorsList[jdx].toString().contains(mainColor.toString()) ? Positioned(
                                                      child: Center(
                                                        child: Container(
                                                          width: 42, height: 42,
                                                          decoration: BoxDecoration(
                                                            color: Colors.transparent,
                                                            border: Border.all(width: 3, color: Colors.white),
                                                            borderRadius: BorderRadius.circular(100)
                                                          ),
                                                        ),
                                                      )
                                                    ) : const SizedBox()
                                                  else
                                                    colorsList[colorPallet][jdx].toString() == mainColor.toString() ? Positioned(
                                                        child: Center(
                                                          child: Container(
                                                            width: 42, height: 42,
                                                            decoration: BoxDecoration(
                                                                color: Colors.transparent,
                                                                border: Border.all(width: 3, color: Colors.white),
                                                                borderRadius: BorderRadius.circular(100)
                                                            ),
                                                          ),
                                                        )
                                                    ) : const SizedBox()
                                                ],
                                              ),
                                            ),
                                          )
                                    ],
                                  )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            colorSecondScreen ? TextButton(
                              onPressed: () {
                                setState((){
                                  colorSecondScreen = false;
                                });
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xff8a8a8a).withOpacity(0.25)),
                              ),
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff676767),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ) : TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xff8a8a8a).withOpacity(0.25)),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff676767),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                widget.changeState(mainColor, mainIcon);
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xff8a8a8a).withOpacity(0.25)),
                              ),
                              child: const Text(
                                "Done",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff676767),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}