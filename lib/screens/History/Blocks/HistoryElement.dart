import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HistoryElement extends StatefulWidget {
  const HistoryElement({Key? key, required this.data, required this.header}) : super(key: key);
  final Map<dynamic, dynamic> data;
  final bool header;

  @override
  State<HistoryElement> createState() => HistoryElementState();
}

class HistoryElementState extends State<HistoryElement> {
  String day = "0";
  String month = "";
  var data = {};

  @override
  void initState() {
    data = widget.data;
    day = DateTime.fromMillisecondsSinceEpoch(data["date"]).day.toString();
    month = getMonthName(DateTime.fromMillisecondsSinceEpoch(data["date"]).month);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String getTime(int time){
      int hours = 0, minutes = 0;
      String finalTime = "";
      for(var i = 0; i < time; i++){
        if(i % 60 == 0){
          minutes++;
          if(minutes % 60 == 0){
            hours++;
            minutes = 0;
          }
        }
      }
      if(hours < 1){
        finalTime = "${minutes.toString()} min";
      } else {
        finalTime = "${hours < 10 ? '0' : ''}${hours.toString()}:${minutes < 10 ? '0' : ''}${minutes.toString()}";
      }
      return finalTime;
    }

    String getWeekDay(int day) {
      String weekDay = "";
      switch(day){
        case 1: weekDay = "Monday"; break;
        case 2: weekDay = "Tuesday"; break;
        case 3: weekDay = "Wednesday"; break;
        case 4: weekDay = "Thursday"; break;
        case 5: weekDay = "Friday"; break;
        case 6: weekDay = "Saturday"; break;
        case 7: weekDay = "Sunday"; break;
      }
      return weekDay;
    }

    String getDay() {
      String day = "";
      DateTime now = DateTime.now();
      DateTime oldTime = DateTime.fromMillisecondsSinceEpoch(data["date"]);

      switch(DateTime(oldTime.year, oldTime.month, oldTime.day).difference(DateTime(now.year, now.month, now.day)).inDays){
        case 0: day = "Today"; break;
        case -1: day = "Yesterday"; break;
        default: day = getWeekDay(oldTime.weekday);
      }
      return day;
    }

    String getTimeType(String timeType){
      String _timeType = "";
      switch(timeType){
        case "useful": _timeType = "Useful"; break;
        case "rest": _timeType = "Rest"; break;
        case "wasted": _timeType = "Wasted"; break;
      }
      return _timeType;
    }

    Color getTimeColor(String timeType){
      Color _timeColor = const Color(0xffffffff);
      switch(timeType){
        case "useful": _timeColor = Colors.green; break;
        case "rest": _timeColor = Colors.orangeAccent; break;
        case "wasted": _timeColor = Colors.redAccent; break;
      }
      return _timeColor;
    }

    return SizedBox(
      child: Column(
        children: [
          if(widget.header)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: const Color(0xffe5e5e5),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      color: Color(0xff626262),
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      fontFamily: "Inter",
                    ),
                  ),
                  const SizedBox(width: 5),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: getDay(),
                            style: const TextStyle(
                              color: Color(0xff868686),
                            ),
                          ),
                          TextSpan(
                              text: "\n$month",
                              style: const TextStyle(
                                color: Color(0xff626262),
                                fontWeight: FontWeight.w600,
                              )
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),
          TextButton(
            onPressed: (){print("Short Press!");},
            onLongPress: (){print("Long Press!");},
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith((states) => const Color(0xffe3e3e3)),
              padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 42, height: 42,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(int.parse("0xff${data["catColor"]}")),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        Positioned(
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/category-icons/${data["catIcon"]}.svg",
                              color: Colors.white,
                              height: 24, width: 24,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 7),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          data["catTitle"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color(0xff212121),
                              fontSize: 15,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Text(
                        getTimeType(data["catType"]),
                        style: TextStyle(
                            color: getTimeColor(data["catType"]),
                            fontSize: 15,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    getTime(data["time"]),
                    style: TextStyle(
                        color: getTimeColor(data["catType"]),
                        fontSize: 15,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

String getMonthName(int monthNum) {
  String monthName = "";
  switch(monthNum){
    case 1: monthName = "January"; break;
    case 2: monthName = "February"; break;
    case 3: monthName = "March"; break;
    case 4: monthName = "April"; break;
    case 5: monthName = "May"; break;
    case 6: monthName = "June"; break;
    case 7: monthName = "Jule"; break;
    case 8: monthName = "August"; break;
    case 9: monthName = "September"; break;
    case 10: monthName = "October"; break;
    case 11: monthName = "November"; break;
    case 12: monthName = "December"; break;
  }
  return monthName;
}