import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  State<HistoryList> createState() => HistoryListState();
}

class HistoryListState extends State<HistoryList> {
  List transactions = [
    {
      "id": 0,
      "category_id": 1,
      "date": DateTime.now().millisecondsSinceEpoch,
      "time": 880,
    },
    {
      "id": 1,
      "category_id": 3,
      "date": DateTime.now().millisecondsSinceEpoch,
      "time": 3200,
    },
    {
      "id": 2,
      "category_id": 2,
      "date": DateTime.now().millisecondsSinceEpoch,
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

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        for(var idx = 0; idx < 20; idx++)
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
                    const Text(
                      "18",
                      style: TextStyle(
                        color: Color(0xff626262),
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        fontFamily: "Inter",
                      ),
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      text: const TextSpan(
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
                                text: "\nSeptember 2022",
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
              Container(
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
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          Positioned(
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/category-icons/book.svg",
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
                      children: const [
                        SizedBox(
                          width: 200,
                          child: Text(
                            "This is a test name of a transaction object from a category",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xff212121),
                                fontSize: 15,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Text(
                          "Useful",
                          style: TextStyle(
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
                      "50 min",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}