import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'bottomNavBar/game_page.dart';
import 'file:///C:/Users/oguzh/FlutterProjects/learn_english/learn_english/lib/bottomNavBar/home_page.dart';

import 'bottomNavBar/quiz_home.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                color: Colors.blueAccent,
                key: _bottomNavigationKey,
                height: 50,
                backgroundColor: Colors.white,
                items: <Widget>[
                  Icon(Icons.home, color: Colors.white,),
                  Icon(Icons.assignment_outlined, color: Colors.white,),
                  Icon(Icons.category, color: Colors.white,)
                ],
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              body: (currentIndex == 0) ? HomePage()
                  : (currentIndex == 1) ? QuizHome()
                  :  GamePage()

      ),
    );
  }
}

