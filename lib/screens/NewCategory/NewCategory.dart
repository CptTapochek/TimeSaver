import 'package:flutter/material.dart';
import 'package:time_saver/screens/NewCategory/Blocks/NewCategoryAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_saver/screens/NewCategory/Modals/timeLimit.dart';
import 'package:time_saver/screens/NewCategory/Modals/chooseIconColor.dart';
import 'package:time_saver/Data/iconsColors.dart';


class NewCategory extends StatefulWidget {
  const NewCategory({Key? key}) : super(key: key);

  @override
  State<NewCategory> createState() => NewCategoryState();
}

class NewCategoryState extends State<NewCategory> {
  var colorData = getRandomColor();
  Color mainColor = const Color(0xff000000);
  String mainIcon = getRandomIcons();
  final FocusNode _focusNode = FocusNode();
  Color labelTextColor = const Color(0xffffffff);
  var dropDownValue = "Useful";
  String title = "";
  String timeType = "";
  Color dropDownColor = const Color(0xff000000);
  int maxTime = 0, minTime = 0;

  @override
  void initState() {
    timeType = "useful";
    mainColor = colorData["pallet"];

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    _focusNode.addListener(() {
      setState(() {
        labelTextColor = _focusNode.hasFocus ? Colors.blue : Colors.red;
      });
    });

    inputLimitTime(type, value){
      setState((){
        switch(type) {
          case "max":
            maxTime = value;
            break;
          case "min":
            minTime = value;
            break;
        }
        });
    }

    getEnabledIconColor(){
      Color color;
      if(timeType == "useful"){
        color = Colors.green;
      } else if(timeType == "wasted"){
        color = Colors.redAccent;
      } else {
        color = Colors.orangeAccent;
      }
      return color;
    }

    getTime(time){
      int hours = 0, minutes = 0;
      for(var i = 0; i < time; i++){
        if(i % 60 == 0){
          minutes++;
          if(minutes % 60 == 0){
            hours++;
            minutes = 0;
          }
        }
      }
      return "${hours < 10 ? '0' : ''}${hours.toString()}:${minutes < 10 ? '0' : ''}${minutes.toString()}";
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
          ),
          child: AppBarContent(mainColor: mainColor),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: screenHeight, width: screenWidth,
        child: Column(
          children: [
            /* Header */
            Stack(
              children: [
                Positioned(
                  child: Container(
                    width: screenWidth,
                    margin: const EdgeInsets.only(top: 55),
                    child: Column(  /* SETTINGS BLOCK */
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.8,
                          child: Text(
                            "Settings",
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 17,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: screenWidth * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                focusNode: _focusNode,
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  color: Colors.black,
                                  fontSize: 18
                                ),
                                textCapitalization: TextCapitalization.sentences,
                                maxLength: 40,
                                decoration: InputDecoration(
                                  alignLabelWithHint: _focusNode.hasFocus ? true : true,
                                  labelText: "Title",
                                  labelStyle: TextStyle(
                                    color: _focusNode.hasFocus ? mainColor : const Color(0xffbbbaba),
                                    fontSize: _focusNode.hasFocus ? 18 : 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  counterText: "",
                                  hintMaxLines: 1,
                                  fillColor: Colors.transparent,
                                  //enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: mainColor)),
                                  border: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: mainColor)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: mainColor)),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                ),
                                autofocus: false,
                                onChanged: (value){
                                  setState((){
                                    title = value;
                                  });
                                }
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        /* TIME LIMITS/TYPE BLOCK */
                        SizedBox(
                          width: screenWidth * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type",
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 16,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 12),
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  value: dropDownValue,
                                  borderRadius: BorderRadius.circular(5),
                                  items: <String>['Useful', 'Wasted', 'Rest'].map<DropdownMenuItem<String>>((String value) {
                                    setState((){
                                      switch(value){
                                        case "Useful":
                                          dropDownColor = Colors.green;
                                          break;
                                        case "Wasted":
                                          dropDownColor = Colors.redAccent;
                                          break;
                                        case "Rest":
                                          dropDownColor = Colors.orangeAccent;
                                        break;
                                      }
                                    });
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value + " Time" + "   ",
                                        style: TextStyle(color: dropDownColor),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value){
                                    setState((){
                                      dropDownValue = value.toString();
                                      timeType = value.toString().toLowerCase();
                                    });
                                  },
                                  iconEnabledColor: getEnabledIconColor(),
                                  style: const TextStyle(fontSize: 14, fontFamily: "Inter"),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Limits",
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 16,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: (){
                                        showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context){
                                              return TimeLimitModal(context, mainColor: mainColor, boxTitle: "Minimal Time", inputFunction: inputLimitTime);
                                            }
                                        );
                                      },
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateColor.resolveWith((states) => mainColor.withOpacity(0.25)),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.add_rounded, size: 22, color: Color(0xff6e6e6e)),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "Minimal Time",
                                            style: TextStyle(
                                                color: Color(0xff414141),
                                                fontSize: 14,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          minTime > 0 ? Text(
                                            getTime(minTime),
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 14,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400
                                            ),
                                          ) : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  minTime > 0 ? TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateColor.resolveWith((states) => mainColor.withOpacity(0.25)),
                                    ),
                                    onPressed: () {
                                      setState((){
                                        minTime = 0;
                                      });
                                    },
                                    child: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                                  ) : const SizedBox()
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: (){
                                        showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context){
                                              return TimeLimitModal(context, mainColor: mainColor, boxTitle: "Maximal Time", inputFunction: inputLimitTime);
                                            }
                                        );
                                      },
                                      style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => mainColor.withOpacity(0.25))),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.add_rounded, size: 22, color: Color(0xff6e6e6e),),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "Maximal Time",
                                            style: TextStyle(
                                                color: Color(0xff414141),
                                                fontSize: 14,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          maxTime > 0 ? Text(
                                            getTime(maxTime),
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 14,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400
                                            ),
                                          ) : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  maxTime > 0 ? TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateColor.resolveWith((states) => mainColor.withOpacity(0.25)),
                                    ),
                                    onPressed: () {
                                      setState((){
                                        maxTime = 0;
                                      });
                                    },
                                    child: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                                  ) : const SizedBox()
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),
                Positioned(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: mainColor,
                    ),
                  ),
                ),
                Positioned(
                    top: 0, right: 20,
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                            padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero)
                        ),
                        onPressed: () {
                          showDialog<void>(
                              context: context,
                              builder: (BuildContext context){
                                return ChooseIconColor(context, colorData: colorData, mainIcon: mainIcon);
                              }
                          );
                        },
                        child: SizedBox(
                          height: 60, width: 60,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  height: 60, width: 60,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: const Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(60),
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              Positioned(
                                  child: Center(
                                    child: SvgPicture.asset("assets/category-icons/$mainIcon.svg", color: mainColor, width: 30, height: 30),
                                  )
                              ),
                            ],
                          ),
                        )
                    )
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      )
    );
  }
}
