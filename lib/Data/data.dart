import 'package:flutter/material.dart';

/* Test categories data */
getCategoriesData(){
  List data = [
    {
      "category_1":{
        "title": "Rutina",
        "time": 2600,
        "color": Color(0xffc82aec),
        "icon": "airdrop",
        "type": "wasted",
        "limit": true,
        "min": 0,
        "max": 18000
      },
      "category_2":{
        "title": "Serial/Films",
        "time": 1500,
        "color": Color(0xff6d35d0),
        "icon": "airplane",
        "type": "rest",
        "limit": true,
        "min": 0,
        "max": 7200
      },
      "category_3":{
        "title": "Work",
        "time": 5212,
        "color": Color(0xff5c4141),
        "icon": "brush",
        "type": "useful",
        "limit": false,
      },
      "category_4":{
        "title": "Projects",
        "time": 0,
        "color": Color(0xffe79818),
        "icon": "car",
        "type": "useful",
        "limit": false,
      },
      "category_5":{
        "title": "Extra study",
        "time": 498,
        "color": Color(0xff4997dc),
        "icon": "glass",
        "type": "useful",
        "limit": false,
      },
      "category_6":{
        "title": "Sleep",
        "time": 9000,
        "color": Color(0xffb90e36),
        "icon": "heart",
        "type": "rest",
        "limit": true,
        "min": 28800,
        "max": 30700
      },
      "category_7":{
        "title": "Games",
        "time": 4433,
        "color": Color(0xff37af47),
        "icon": "game",
        "type": "rest",
        "limit": true,
        "min": 0,
        "max": 7200
      },
      "category_8":{
        "title": "Friends/Family",
        "time": 0,
        "color": Color(0xffa3af37),
        "icon": "lamp",
        "type": "rest",
        "limit": true,
        "min": 0,
        "max": 7200
      },
      "category_9":{
        "title": "YouTube",
        "time": 4433,
        "color": Color(0xffe15353),
        "icon": "youtube",
        "type": "rest",
        "limit": true,
        "min": 0,
        "max": 7200
      },
      "category_10":{
        "title": "Sport",
        "time": 4433,
        "color": Color(0xff31b9ae),
        "icon": "ship",
        "type": "useful",
        "limit": false,
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

