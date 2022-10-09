import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  State<HistoryList> createState() => HistoryListState();
}

class HistoryListState extends State<HistoryList> {
  List transactionsList = [];
  List transactions = [
    {
      "id": 13545,
      "category_id": 1,
      "date": DateTime.now().subtract(Duration(days: 4)).millisecondsSinceEpoch,
      "time": 880,
    },
    {
      "id": 3123,
      "category_id": 1,
      "date": DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch,
      "time": 7787,
    },
    {
      "id": 343431,
      "category_id": 3,
      "date": DateTime.now().subtract(Duration(minutes: 50)).millisecondsSinceEpoch,
      "time": 3200,
    },
    {
      "id": 11321,
      "category_id": 3,
      "date": DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
      "time": 5600,
    },
    {
      "id": 111166,
      "category_id": 2,
      "date": DateTime.now().subtract(Duration(hours: 2)).millisecondsSinceEpoch,
      "time": 744,
    },
    {
      "id": 56566,
      "category_id": 2,
      "date": DateTime.now().subtract(Duration(hours: 12)).millisecondsSinceEpoch,
      "time": 1890,
    },
  ];

  List categories = [
    {
      "id": 1,
      "title": "Books",
      "color": "B0DFE5",
      "icon": "book",
      "type": "useful"
    },
    {
      "id": 3,
      "title": "Games",
      "color": "8B4000",
      "icon": "game",
      "type": "rest"
    },
    {
      "id": 2,
      "title": "Rutina",
      "color": "6c35a0",
      "icon": "timer",
      "type": "wasted"
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  sortingData(List data, int length, String type) {
    if(type == "asc"){
      for(int i = 0; i < length; i++){
        for(int j = 0; j < length - i - 1; j++){
          if(data[j]["date"] > data[j + 1]["date"]){
            var tmp = data[j];
            data[j] = data[j + 1];
            data[j + 1] = tmp;
          }
        }
      }
    } else if(type == "desc"){
      for(int i = 0; i < length; i++){
        for(int j = 0; j < length - i - 1; j++){
          if(data[j]["date"] < data[j + 1]["date"]){
            var tmp = data[j];
            data[j] = data[j + 1];
            data[j + 1] = tmp;
          }
        }
      }
    }
    return data;
  }

  createTransactionsList() {
    if(categories != null && transactions != null){
      transactionsList = [
        for(int idx = 0; idx < transactions.length; idx++)
          for(int jdx = 0; jdx < categories.length; jdx++)
            if(transactions[idx]["category_id"] == categories[jdx]["id"])
              {
                "date": transactions[idx]["date"],
                "time": transactions[idx]["time"],
                "catTitle": categories[jdx]["title"],
                "catColor": categories[jdx]["color"],
                "catIcon": categories[jdx]["icon"],
                "catType": categories[jdx]["type"]
              }
      ];
      sortingData(transactionsList, transactionsList.length, "asc");
    }
  }

  @override
  Widget build(BuildContext context) {
    createTransactionsList();
    print("++++++++++++++++++++${transactionsList}");

    String getTime(time){
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

    return Column(
      children: [
        for(var idx = 0; idx < transactionsList.length; idx++)
        SizedBox(
          child: Column(
            children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xffe5e5e5),
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(transactionsList[idx]["date"]).day.toString(),
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
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: "Yesterday",
                                style: TextStyle(
                                  color: Color(0xff868686),
                                ),
                              ),
                              TextSpan(
                                  text: "\n${"September"}",
                                  style: TextStyle(
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
                                  color: Color(int.parse("0xff${transactionsList[idx]["catColor"]}")),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            Positioned(
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/category-icons/${transactionsList[idx]["catIcon"]}.svg",
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
                              transactionsList[idx]["catTitle"],
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
                            "Useful",
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Text(
                        getTime(transactionsList[idx]["time"]),
                        style: const TextStyle(
                            color: Colors.green,
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
        )
      ],
    );
  }
}