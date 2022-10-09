import 'package:flutter/material.dart';


class AppBarContent extends StatefulWidget {
  const AppBarContent({Key? key, required this.editState}) : super(key: key);
  final Function editState;

  @override
  State<AppBarContent> createState() => AppBarContentState();
}

class AppBarContentState extends State<AppBarContent> {
  bool closeEditState = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(onPressed: (){}, icon: const Icon(Icons.menu_rounded), color: Colors.white),
                const Text(
                  '1Day',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter"
                  ),
                ),
                IconButton(
                    onPressed: () {
                      widget.editState();
                      setState((){
                        closeEditState = !closeEditState;
                      });
                    },
                    icon: closeEditState ? const Icon(Icons.close_rounded) : const Icon(Icons.edit),
                    color: Colors.white
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                      shadowColor: MaterialStateColor.resolveWith((states) => Colors.transparent)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.5),
                            color: Colors.white,
                          ),
                          child: const Text(
                              '30',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff123959),
                                fontFamily: "Inter",
                              )
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                            'APRIL',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Inter",
                            )
                        ),
                        const SizedBox(width: 5),
                        const Text(
                            '2022',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Inter",
                            )
                        ),
                        const Icon(Icons.arrow_drop_down_sharp, size: 25)
                      ],
                    )
                ),
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                  child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}