import 'package:flutter/material.dart';
import 'package:models/categories_models.dart';
import 'package:repositories/repository.dart';
import 'package:time_saver/screens/NewCategory/Blocks/NewCategoryAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_saver/screens/NewCategory/Modals/timeLimit.dart';
import 'package:time_saver/screens/NewCategory/Modals/chooseIconColor.dart';
import 'package:time_saver/Data/iconsColors.dart';
import 'package:time_saver/main.dart';


class EditCategory extends StatefulWidget {
  const EditCategory({Key? key, required this.data}) : super(key: key);
  final Map<dynamic, dynamic> data;

  @override
  State<EditCategory> createState() => EditCategoryState();
}

class EditCategoryState extends State<EditCategory> {
  var data;
  Color mainColor = const Color(0xffffffff);
  var colorData = getRandomColor();
  String mainIcon = "";
  final FocusNode _focusNode = FocusNode();
  Color labelTextColor = const Color(0xffffffff);
  var dropDownValue = "";
  String title = "";
  String timeType = "";
  Color dropDownColor = const Color(0xff000000);
  int maxTime = 0, minTime = 0;
  bool validateTitle = true;
  late TextEditingController _controller;
  int historyCount = 0;

  @override
  void initState() {
    data = widget.data;
    title = data["title"];
    timeType = data["type"];
    switch(timeType){
      case "useful": dropDownValue = "Useful"; break;
      case "wasted": dropDownValue = "Wasted"; break;
      case "rest": dropDownValue = "Rest"; break;
    }
    mainColor = Color(int.parse("0xff${data["color"]}"));
    mainIcon = data["icon"];
    maxTime = data["max"]; minTime = data["min"];
  super.initState();
    _controller = TextEditingController(text: data['title']);
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

    changeState(color, icon){
      setState((){
        mainIcon = icon;
        mainColor = color;
        colorData["pallet"] = color;
      });
    }

    updateCategory(){
      if(title.trim().isEmpty){
        setState((){
          validateTitle = false;
        });
      } else {
        String mainColorString = mainColor.toString().replaceAll("Color(0xff", "").replaceAll(")", "");

        CategoriesRepository().editCategory(CategoriesModel(
            id: data["id"],
            indexCategory: data["indexCategory"],
            title: title,
            time: data["time"],
            color: mainColorString,
            icon: mainIcon,
            type: timeType,
            min: minTime,
            max: maxTime)
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainPage())
        );
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            decoration: BoxDecoration(
              color: mainColor,
            ),
            child: AppBarContent(mainColor: mainColor, addNewCategory: updateCategory, title: "Edit category",),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
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
                                        controller: _controller,
                                        style: const TextStyle(
                                            fontFamily: "Inter",
                                            color: Colors.black,
                                            fontSize: 18
                                        ),
                                        textCapitalization: TextCapitalization.sentences,
                                        maxLength: 35,
                                        decoration: InputDecoration(
                                          alignLabelWithHint: _focusNode.hasFocus ? true : true,
                                          labelText: "Title",
                                          labelStyle: TextStyle(
                                            color: _focusNode.hasFocus ? mainColor : validateTitle ? const Color(0xffbbbaba) : Colors.red,
                                            fontSize: _focusNode.hasFocus ? 18 : 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          counterText: "",
                                          hintMaxLines: 1,
                                          fillColor: Colors.transparent,
                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: validateTitle ? const Color(0xffbbbaba) : Colors.red)),
                                          border: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: mainColor)),
                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: mainColor)),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                        ),
                                        autofocus: false,
                                        onChanged: (value){
                                          setState((){
                                            title = value;
                                            validateTitle = true;
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
                                                const Icon(Icons.add_rounded, size: 22, color: Color(0xff6e6e6e)),
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
                                    ),
                                    const SizedBox(height: 20),
                                    TextButton(
                                      onPressed: (){
                                        showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context){
                                              return AlertDialog(
                                                contentPadding: EdgeInsets.zero,
                                                insetPadding: EdgeInsets.zero,
                                                content: Container(
                                                  height: 220,
                                                  width: screenWidth * 0.9,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.all(20),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  height: 40, width: 40,
                                                                  child: Stack(
                                                                    children: [
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          color: mainColor,
                                                                          borderRadius: BorderRadius.circular(10)
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        child: Center(
                                                                          child: SvgPicture.asset(
                                                                            "assets/category-icons/$mainIcon.svg",
                                                                            width: 20, height: 20,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 10),
                                                                SizedBox(
                                                                  width: screenWidth * 0.65,
                                                                  child: Text(
                                                                    "Delete $title ?",
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: const TextStyle(
                                                                        fontFamily: "Inter",
                                                                        fontSize: 15,
                                                                        fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(top: 20),
                                                              child: Text(
                                                                "All historical operations ($historyCount) associated with the category will be deleted.",
                                                                style: const TextStyle(
                                                                  color: Color(0xff919191),
                                                                  fontFamily: "Inter",
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w400
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(top: 20),
                                                              child: const Text(
                                                                "The category cannot be restored. Are you sure you want to delete the category?",
                                                                style: TextStyle(
                                                                    color: Color(0xff919191),
                                                                    fontFamily: "Inter",
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w400
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 0, right: 20,
                                                        child: Row(
                                                          children: [
                                                            TextButton(
                                                              onPressed: () => Navigator.pop(context),
                                                              style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xffd5d5d5))),
                                                              child: const Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontFamily: "Inter"
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(width: 20),
                                                            TextButton(
                                                              onPressed: () {
                                                                CategoriesRepository().deleteCategoryId(data["id"]);
                                                                Navigator.push(context,
                                                                    MaterialPageRoute(builder: (context) => const MainPage())
                                                                );
                                                              },
                                                              style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xffd5d5d5))),
                                                              child: const Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                  color: Colors.redAccent,
                                                                  fontFamily: "Inter"
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ),
                                              );
                                            }
                                        );
                                      },
                                      style: ButtonStyle(
                                          overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xffd5d5d5)),
                                          padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(left: 8))
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                            size: 23,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Delete category",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 15,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      ),
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
                                  return ChooseIconColor(
                                    context,
                                    colorData: colorData,
                                    mainIcon: mainIcon,
                                    changeState: changeState,
                                    existCategoryColor: mainColor
                                  );
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
                                          borderRadius: BorderRadius.circular(15),
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
          ),
        )
    );
  }
}
