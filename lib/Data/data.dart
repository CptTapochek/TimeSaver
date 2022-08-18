import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


/* Test categories data */
getCategoriesData(){
  List data = [
    {
      "category_1":{
        "index": 1,
        "title": "Rutina",
        "time": 2600,
        "color": "c82aec",
        "icon": "airdrop",
        "type": "wasted",
        "min": 0,
        "max": 18000
      },
      "category_2":{
        "index": 2,
        "title": "Serial/Films",
        "time": 1500,
        "color": "6d35d0",
        "icon": "airplane",
        "type": "rest",
        "min": 0,
        "max": 7200
      },
      "category_3":{
        "index": 3,
        "title": "Work",
        "time": 5212,
        "color": "5c4141",
        "icon": "brush",
        "type": "useful",
        "min": 0,
        "max": 0
      },
      "category_4":{
        "index": 4,
        "title": "Projects",
        "time": 0,
        "color": "e79818",
        "icon": "car",
        "type": "useful",
        "min": 0,
        "max": 0
      },
      "category_5":{
        "index": 5,
        "title": "Extra study",
        "time": 498,
        "color": "4997dc",
        "icon": "glass",
        "type": "useful",
        "min": 0,
        "max": 0
      },
      "category_6":{
        "index": 6,
        "title": "Sleep",
        "time": 9000,
        "color": "b90e36",
        "icon": "heart",
        "type": "rest",
        "min": 28800,
        "max": 30700
      },
      "category_7":{
        "index": 7,
        "title": "Games",
        "time": 4433,
        "color": "37af47",
        "icon": "game",
        "type": "rest",
        "min": 0,
        "max": 7200
      },
      "category_8":{
        "index": 8,
        "title": "Friends/Family",
        "time": 0,
        "color": "a3af37",
        "icon": "lamp",
        "type": "rest",
        "min": 0,
        "max": 7200
      },
      "category_9":{
        "index": 9,
        "title": "YouTube",
        "time": 4433,
        "color": "e15353",
        "icon": "youtube",
        "type": "rest",
        "min": 0,
        "max": 7200
      },
      "category_10":{
        "index": 10,
        "title": "Sport",
        "time": 4433,
        "color": "31b9ae",
        "icon": "ship",
        "type": "useful",
        "min": 0,
        "max": 0
      },
      "category_11": null,
      "category_12": null,
      "category_13": null,
      "category_14": null,
      "category_15": null,
      "category_16": null,
      "category_17": null,
      "category_18": null,
      "category_19": null,
      "category_20": null,
    }
  ];

  return data;
}

