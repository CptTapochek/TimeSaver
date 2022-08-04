import 'dart:math';
import 'package:flutter/material.dart';
import 'package:time_saver/Blocks/NewCategoryAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NewCategory extends StatefulWidget {
  const NewCategory({Key? key}) : super(key: key);

  @override
  State<NewCategory> createState() => NewCategoryState();
}

getRandomColor(){
  Color color = const Color(0xff000000);

  List colors = [
    /* Red */
    const Color(0xffce356d), const Color(0xffed282e), const Color(0xfff7b2a0),
    const Color(0xfffcc4d8), const Color(0xfff72c81), const Color(0xfff7a8c9),
    const Color(0xfff9bbd0), const Color(0xfff71621), const Color(0xffeaa99f),
    /* Orange */
    const Color(0xffed8849), const Color(0xfff7842c), const Color(0xffe5aa14),
    const Color(0xffeaad62), const Color(0xffffe4c1), const Color(0xffbc5409),
    const Color(0xffe5a877), const Color(0xffe2ac6f), const Color(0xffffd5b5),
    /* Yellow */
    const Color(0xffeacd25), const Color(0xffd8d811), const Color(0xffd8d811),
    const Color(0xffedf26a), const Color(0xfff9ea5c), const Color(0xfff9cd04),
    const Color(0xffdee522), const Color(0xfffcefa4), const Color(0xffd6d60a),
    /* Green */
    const Color(0xff5ef96b), const Color(0xff6be09a), const Color(0xff6be09a),
    const Color(0xff028e36), const Color(0xff769b17), const Color(0xffebfc6f),
    const Color(0xff83c605), const Color(0xff40ed88), const Color(0xff6ef49d),
    /* Blue */
    const Color(0xff404cf7), const Color(0xffa19aed), const Color(0xff254487),
    const Color(0xff28809b), const Color(0xffabd4ea), const Color(0xff45c1e0),
    const Color(0xff2e3bd1), const Color(0xff4f57ef), const Color(0xff4c8de8),
    /* Pink */
    const Color(0xffffc9f4), const Color(0xffecb1ef), const Color(0xffe021ca),
    const Color(0xfffc79fc), const Color(0xfff96de2), const Color(0xffd381db),
    const Color(0xfff9b1f2), const Color(0xffe524be), const Color(0xffdb60c6),
    /* Purple */
    const Color(0xffb48af7), const Color(0xff8c65d3), const Color(0xffb394e8),
    const Color(0xff6c35a0), const Color(0xffb496f2), const Color(0xff974bf4),
    const Color(0xff9048b5), const Color(0xffb282e0), const Color(0xff7418a3),
    /* Grey */
    const Color(0xff262626), const Color(0xff666666), const Color(0xff5e5e5e),
    const Color(0xff050505), const Color(0xff545454), const Color(0xffe0e0e0),
    const Color(0xff636363), const Color(0xff939393), const Color(0xff525252),
  ];

  int randomIndex = Random().nextInt(colors.length);
  for(var idx = 0; idx < colors.length; idx++){
    if(idx == randomIndex){
      color = colors[idx];
    }
  }
  return color;
}

getRandomIcons(){
  String icon = "";

  List icons = [
    "airdrop", "airplane", "bag", "bag-2", "book", "book-saved", "book-square", "box", "briefcase", "brush", "calculator",
    "car", "cloud-connection", "code", "code-circle", "coin", "driving", "game", "gameboy", "gift", "glass", "global-search",
    "headphone", "heart", "lamp", "lovely", "map", "message-programming", "messages", "messages-2", "messenger", "microscope",
    "monitor", "moon", "mouse", "note-2", "people", "profile-2user", "shapes", "ship", "shop", "speaker", "teacher", "time",
    "usd-coin-(usdc)", "weight", "youtube", "zoom"
  ];

  int randomIndex = Random().nextInt(icons.length);
  for(var idx = 0; idx < icons.length; idx++){
    if(idx == randomIndex){
      icon = icons[idx];
    }
  }
  return icon;
}


class NewCategoryState extends State<NewCategory> {
  Color mainColor = getRandomColor();
  String mainIcon = getRandomIcons();
  final FocusNode _focusNode = FocusNode();
  Color labelTextColor = const Color(0xffffffff);
  String title = "";

  @override
  void initState() {
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

    print(title);
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
        color: Color(0xffe5e5e5),
        height: screenHeight, width: screenWidth,
        child: Column(
          children: [
            /* Header */
            Container(
              height: screenHeight * 0.5,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: screenHeight * 0.5, width: screenWidth,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 55),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.8,
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 16,
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
                                      ),
                                      counterText: "",
                                      hintMaxLines: 1,
                                      fillColor: Colors.transparent,
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: mainColor)),
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
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                Text("Limits")//Test Commit
                              ],
                            )
                          ],
                        ),
                      )
                    ),
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
                          onPressed: () {},
                          child: Container(
                            height: 55, width: 55,
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                    height: 55, width: 55,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 8,
                                            offset: const Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Positioned(
                                    child: Center(
                                      child: SvgPicture.asset("assets/category-icons/$mainIcon.svg", color: mainColor, width: 35, height: 35),
                                    )
                                ),
                              ],
                            ),
                          )
                      )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      )
    );
  }
}
