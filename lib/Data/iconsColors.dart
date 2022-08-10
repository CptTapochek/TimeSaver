import 'dart:math';
import 'package:flutter/material.dart';

List colors = [
  /* Red */
  [
    const Color(0xff5E1914), const Color(0xffD21F3C), const Color(0xffCA3433), const Color(0xffBF0A30), const Color(0xffFF2800),
    const Color(0xff420D09), const Color(0xffB80F0A), const Color(0xff8D021F), const Color(0xff933A16), const Color(0xffB7365B),
  ],
  [
    const Color(0xffFF0901), const Color(0xff7D181C), const Color(0xffEC3B55), const Color(0xffA35954), const Color(0xff810002),
    const Color(0xffB32124), const Color(0xffE20F5D), const Color(0xffC41709), const Color(0xffCF5B5D), const Color(0xffF77D74),
    const Color(0xffEE3024),
  ],

  /* Orange */
  [
    const Color(0xffFC6600), const Color(0xffF9812A), const Color(0xff8B4000), const Color(0xffF9A602), const Color(0xffFD6A02),
    const Color(0xff883000), const Color(0xffEB9605), const Color(0xff793802), const Color(0xffFF7417), const Color(0xff964000),
  ],
  [
    const Color(0xff813F0B), const Color(0xffEF7215), const Color(0xffFDA50F), const Color(0xffCC7722), const Color(0xffEF820D),
    const Color(0xffB1560F), const Color(0xffB3672B), const Color(0xffCB5C0D), const Color(0xffD7722C), const Color(0xffFFBF00),
    const Color(0xffF05E23), const Color(0xffF79862)
  ],

  /* Yellow */
  [
    const Color(0xffF8DE7E), const Color(0xffFADA5E), const Color(0xffF9A602), const Color(0xffFFD300), const Color(0xffD2B55B),
    const Color(0xffC3B091), const Color(0xffDAA520), const Color(0xffFCF4A3), const Color(0xffFCD12A), const Color(0xffFFC30B),
  ],
  [
    const Color(0xffC49102), const Color(0xffFCE205), const Color(0xffFDA50F), const Color(0xffCC7722), const Color(0xffFFBF00),
    const Color(0xffEEDC82), const Color(0xffFFE5B4), const Color(0xffEFFD5F), const Color(0xffF8E473), const Color(0xffFEDC56),
    const Color(0xffFFDDAF), const Color(0xffCEB180),
  ],

  /* Green */
  [
    const Color(0xff0B6623), const Color(0xff9DC183), const Color(0xff708238), const Color(0xffC6E945), const Color(0xff3E704C),
    const Color(0xff00A86B), const Color(0xff8E9678), const Color(0xff4F7942), const Color(0xff29AB87), const Color(0xffA9B99C),
    const Color(0xff89995A), const Color(0xff97FB97),
  ],
  [
    const Color(0xffD0F0BF), const Color(0xff01796F), const Color(0xff00A572),
    const Color(0xff4B5320), const Color(0xff4FC777), const Color(0xff4BBA16), const Color(0xff39FF14), const Color(0xff444B37),
    const Color(0xff043927), const Color(0xff679167), const Color(0xff50C778), const Color(0xff2E8B57)
  ],

  /* Blue */
  [
    const Color(0xff3FE0D0), const Color(0xffB0DFE5), const Color(0xff95C8D8), const Color(0xff7EF9FF), const Color(0xff588BAE),
    const Color(0xff89CFF0), const Color(0xff81D8D0), const Color(0xff4682B4), const Color(0xff57A0D3), const Color(0xff4F97A3),
    const Color(0xff7285A5), const Color(0xff73C2FB),
  ],
  [
    const Color(0xff1034A6), const Color(0xff008081), const Color(0xff4C516D), const Color(0xff6593F5),
    const Color(0xff008ECC), const Color(0xff0F52BA), const Color(0xff0080FF), const Color(0xff0E4D92),
    const Color(0xff000080), const Color(0xff003152), const Color(0xff1D2951), const Color(0xff111E6C)
  ],

  /* Pink */
  [
    const Color(0xffFDAB9F), const Color(0xffFE7F9C), const Color(0xffDF5286), const Color(0xffF5C3C2), const Color(0xffFE5BAC),
    const Color(0xffFF69B4), const Color(0xffF987C5), const Color(0xffF19CBB), const Color(0xffFF66CC), const Color(0xffFF66CC),
    const Color(0xffFB607F),
  ],
  [
    const Color(0xffFF00FF), const Color(0xffFCA3B7), const Color(0xffFFA6C9), const Color(0xffDE6FA1), const Color(0xffFDB9C8),
    const Color(0xffDE3163), const Color(0xffFF6FFF), const Color(0xffEC5578), const Color(0xffF64A8A), const Color(0xffF81894),
    const Color(0xffFC0FC0)
  ],

  /* Purple */
  [
    const Color(0xffb48af7), const Color(0xff8c65d3), const Color(0xffb394e8), const Color(0xff6c35a0), const Color(0xffb496f2),
    const Color(0xff974bf4), const Color(0xff9048b5), const Color(0xffb282e0), const Color(0xff7418a3), const Color(0xffE0B1FF),
  ],
  [
    const Color(0xff760371), const Color(0xffDA72D6), const Color(0xff68053E), const Color(0xff63366D), const Color(0xff730397),
    const Color(0xffCDADDB), const Color(0xff63366D), const Color(0xff9669E0), const Color(0xff9270CB), const Color(0xff887DAF),
  ],

  /* Grey */
  [
    const Color(0xffa8a8a8), const Color(0xff262626), const Color(0xff666666), const Color(0xff5e5e5e), const Color(0xff1e1e18),
    const Color(0xff545454), const Color(0xff6E7884), const Color(0xff636363), const Color(0xff939393), const Color(0xff525252),
    const Color(0xff323234), const Color(0xffB5B5B7)
  ],
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
  Color pallet = const Color(0xff000000);
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
          pallet = colorArray[jdx];
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