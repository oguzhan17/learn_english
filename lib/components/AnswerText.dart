import 'package:flutter/material.dart';

class AnswerText extends StatelessWidget {
  final String textAnswer;
  final double screenWidth;
  const AnswerText(this.textAnswer,this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: screenWidth,
      child: Text(
        "$textAnswer",
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}