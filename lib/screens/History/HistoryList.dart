import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_saver/screens/History/Blocks/HistoryElement.dart';

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
      sortingData(transactionsList, transactionsList.length, "desc");
    }
  }

  @override
  Widget build(BuildContext context) {
    createTransactionsList();

    bool getDaysDifference(int firsTime, int secondTime){
      bool response = false;
      DateTime _firstTime = DateTime.fromMillisecondsSinceEpoch(firsTime);
      DateTime _secondTime = DateTime.fromMillisecondsSinceEpoch(secondTime);
      var difference = DateTime(_secondTime.year, _secondTime.month, _secondTime.day).difference(DateTime(_firstTime.year, _firstTime.month, _firstTime.day)).inDays;
      if(difference == 0){
        response = false;
      } else {
        response = true;
      }
      return response;
    }

    return Column(
      children: [
        for(var idx = 0; idx < transactionsList.length; idx++)
          HistoryElement(
            data: transactionsList[idx],
            header: idx == 0 ? true : getDaysDifference(transactionsList[idx]["date"], transactionsList[idx - 1]["date"]),
          ),
      ],
    );
  }
}