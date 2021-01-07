import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_english/bottom.dart';
import 'package:learn_english/bottomNavBar/game_page.dart';
import 'package:learn_english/bottomNavBar/quiz_page.dart';
import 'package:learn_english/home_page.dart';
import 'package:learn_english/second_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Bottom(),
      ),
    );
  }
}
