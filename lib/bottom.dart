import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:learn_english/bottomNavBar/game_page.dart';
import 'package:learn_english/bottomNavBar/quiz_page.dart';
import 'package:learn_english/home_page.dart';

class Bottom extends StatefulWidget {


  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int currentIndex;

  GlobalKey _bottomNavigationKey = GlobalKey();
@override
  void initState() {
    super.initState();
    currentIndex = 0;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              height: 50,
              backgroundColor: Colors.blueAccent,
              items: <Widget>[
                Icon(Icons.home),
                Icon(Icons.assignment_outlined),
                Icon(Icons.category)
              ],
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            body: (currentIndex == 0) ? HomePage()
                : (currentIndex == 1) ? QuizPage()
                :  GamePage()

    );
  }
}

