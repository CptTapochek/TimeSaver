import 'dart:math';
import 'package:flutter/material.dart';

List colors = [
  /* Red */
  ["5E1914", "D21F3C", "CA3433", "BF0A30", "FF2800", "420D09", "B80F0A", "8D021F", "933A16", "B7365B"],
  ["FF0901", "7D181C", "EC3B55", "A35954", "810002", "B32124", "E20F5D", "C41709", "CF5B5D", "F77D74", "EE3024"],

  /* Orange */
  ["FC6600", "F9812A", "8B4000", "F9A602", "FD6A02", "883000", "EB9605", "793802", "FF7417", "964000"],
  ["813F0B", "EF7215", "FDA50F", "CC7722", "EF820D", "B1560F", "B3672B", "CB5C0D", "D7722C", "FFBF00", "F05E23", "F79862"],

  /* Yellow */
  ["F8DE7E", "FADA5E", "F9A602", "FFD300", "D2B55B", "C3B091", "DAA520", "FCF4A3", "FCD12A", "FFC30B"],
  ["C49102", "FCE205", "FDA50F", "CC7722", "FFBF00", "EEDC82", "FFE5B4", "EFFD5F", "F8E473", "FEDC56", "FFDDAF", "CEB180"],

  /* Green */
  ["0B6623", "9DC183", "708238", "C6E945", "3E704C", "00A86B", "8E9678", "4F7942", "29AB87", "A9B99C", "89995A", "97FB97"],
  ["D0F0BF", "01796F", "00A572", "4B5320", "4FC777", "4BBA16", "39FF14", "444B37", "043927", "679167", "50C778", "2E8B57"],

  /* Blue */
  ["3FE0D0", "B0DFE5", "95C8D8", "7EF9FF", "588BAE", "89CFF0", "81D8D0", "4682B4", "57A0D3", "4F97A3", "7285A5", "73C2FB"],
  ["1034A6", "008081", "4C516D", "6593F5", "008ECC", "0F52BA", "0080FF", "0E4D92", "000080", "003152", "1D2951", "111E6C"],

  /* Pink */
  ["FDAB9F", "FE7F9C", "DF5286", "F5C3C2", "FE5BAC", "FF69B4", "F987C5", "F19CBB", "FF66CC", "FF66CC", "FB607F"],
  ["ff00ff", "fca3b7", "ffa6c9", "de6fa1", "FDB9C8", "DE3163", "FF6FFF", "EC5578", "F64A8A", "F81894", "FC0FC0"],

  /* Purple */
  ["b48af7", "8c65d3", "b394e8", "6c35a0", "b496f2", "974bf4", "9048b5", "b282e0", "7418a3", "e0b1ff"],
  ["760371", "da72d6", "68053e", "63366d", "730397", "cdaddb", "63366d", "9669e0", "9270cb", "887daf"],

  /* Grey */
  ["a8a8a8", "262626", "666666", "5e5e5e", "1e1e18", "545454", "6e7884", "636363", "939393", "525252", "323234", "b5b5b7"],
];

List icons = [
  "airdrop", "airplane", "bag", "bag-2", "book", "book-saved", "book-square", "box", "briefcase", "brush", "calculator",
  "car", "cloud-connection", "code", "code-circle", "coin", "driving", "game", "gameboy", "gift", "glass", "global-search",
  "headphone", "heart", "lamp", "lovely", "map", "message-programming", "messages", "messages-2", "messenger", "microscope",
  "monitor", "moon", "mouse", "note-2", "people", "profile-2user", "shapes", "ship", "shop", "speaker", "teacher", "timer",
  "usd-coin-(usdc)", "weight", "youtube", "zoom"
];

getRandomColor(){
  dynamic colorArray;
  Color pallet = const Color(0xffffffff);
  String color = "";

  int randomColorIndex = Random().nextInt(colors.length);
  for(var idx = 0; idx < colors.length; idx++){
    if(idx == randomColorIndex){
      colorArray = colors[idx];
      switch (idx){
        case 0: color = "red"; break;
        case 1: color = "orange"; break;
        case 2: color = "yellow"; break;
        case 3: color = "green"; break;
        case 4: color = "blue"; break;
        case 5: color = "pink"; break;
        case 6: color = "purple"; break;
        case 7: color = "grey"; break;
      }
      int randomPaletteIndex = Random().nextInt(colorArray.length);
      for(var jdx = 0; jdx < colorArray.length; jdx++){
        if(jdx == randomPaletteIndex){
          pallet = Color(int.parse("0xff${colorArray[jdx]}"));
        }
      }
    }
  }

  var colorData = {
    "pallet": pallet,
    "color": color,
  };

  return colorData;
}

getRandomIcons(){
  String icon = "";

  int randomIndex = Random().nextInt(icons.length);
  for(var idx = 0; idx < icons.length; idx++){
    if(idx == randomIndex){
      icon = icons[idx];
    }
  }
  return icon;
}

getListOfIcons(){
  return icons;
}
getListOfColors(){
  return colors;
}