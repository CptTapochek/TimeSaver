import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_saver/Blocks/AppBar.dart';
import 'package:time_saver/screens/Category/Category.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_saver/screens/History/HistoryList.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}


class MainPageState extends State<MainPage> {
  Color mainColor = const Color(0xff5c6ac0);
  bool editCategories = false;

  @override
  void initState(){
    super.initState();
  }

  void editCategoriesState(){
    setState((){
      editCategories = !editCategories;
    });
  }

  int selectedIndex = 1;


  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const SingleChildScrollView(
          child: HistoryList()
      ),
      SingleChildScrollView(
          child: CategoryPage(editCategories: editCategories)
      ),
      const Text(
        'Index 2: Overview',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ];

    void getBottomTap(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0652C5), Color(0xffD4418E)],
              begin: Alignment.centerLeft, end: Alignment.bottomRight
            )
          ),
          child: AppBarContent(editState: editCategoriesState),
        ),
      ),
      body: _widgetOptions.elementAt(selectedIndex),
      floatingActionButton: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
          padding: MaterialStateProperty.all(const EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20))
        ),
        onPressed: () => getBottomTap(1),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 77, width: 45,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                top: selectedIndex == 1 ? 7 : 0,
                child: SizedBox(
                  height: 70, width: 45,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xffD4418E), Color(0xff0652C5)],
                            begin: Alignment.topLeft, end: Alignment.bottomRight
                          )
                        ),
                      ),
                      Positioned(
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/system-icons/doughnut_chart_light.svg",
                            width: 32, height: 32, color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        )
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: BottomAppBar(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: TextButton(
                      onPressed: () => getBottomTap(0),
                      style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                          padding: MaterialStateProperty.all(const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10))
                      ),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 150),
                        scale: selectedIndex == 0 ? 1.1 : 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/system-icons/clock.svg",
                              width: 24, height: 24, color: const Color(0xffD4418E),
                            ),
                            const Text(
                              "History",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Inter",
                                  color: Color(0xffD4418E)
                              ),
                            ),
                          ],
                        ),
                      )
                  )),
                  const Expanded(child: Text('')),
                  Expanded(child: TextButton(
                      style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                          padding: MaterialStateProperty.all(const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10))
                      ),
                      onPressed: () => getBottomTap(2),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 150),
                        scale: selectedIndex == 2 ? 1.1 : 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/system-icons/chart.svg",
                              width: 23, height: 23, color: const Color(0xff0652C5),
                            ),
                            const Text(
                              "Overview",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Inter",
                                  color: Color(0xff0652C5)
                              ),
                            )
                          ],
                        ),
                      )
                  )),
                ],
              ),
            )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
