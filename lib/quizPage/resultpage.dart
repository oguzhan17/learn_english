import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../bottom.dart';

class resultpage extends StatefulWidget {
  int marks;
  resultpage({Key key , @required this.marks}) : super(key : key);
  @override
  _resultpageState createState() => _resultpageState(marks);
}

class _resultpageState extends State<resultpage> {

  List<String> images = [
    "assets/lottie/confetti.json",
    "assets/lottie/jumping.json",
    "assets/lottie/lazy.json",
  ];

  String message;
  String image;

  @override
  void initState(){
    if(marks < 40){
      image = images[2];
      message = "Daha çok çalışmalısın..\n" + "Puanın : $marks";
    }else if(marks < 80){
      image = images[1];
      message = "Daha iyisini yapabilirsin!\n" + "Puanın : $marks";
    }else{
      image = images[0];
      message = "Tebrikler!\n" + "Puanın : $marks ";
    }
    super.initState();
  }

  int marks;
  _resultpageState(this.marks);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sonuç",
        ),
      ),
      body: Column(
        children: <Widget>[
          Material(
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.5,
                      child: ClipRect(
                        child: Container(
                          child: Lottie.asset(image,
                            fit: BoxFit.scaleDown),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: OutlineButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Bottom(),
                ));
              },
              child: Text(
                "Ana sayfaya dön.",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Nunito'
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              borderSide: BorderSide(width: 3.0, color: Colors.indigo),
              splashColor: Colors.indigoAccent,
            ),
          )
        ],
      ),
    );
  }
}