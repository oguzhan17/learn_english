import 'package:flutter/material.dart';
import 'AnswerText.dart';

class AnswerButton extends StatelessWidget {
  final bool isQuizStarted;
  final Function checkAnswer;
  final String optionText;
  final double screenWidth;

  AnswerButton(
      this.optionText, this.isQuizStarted, this.checkAnswer, this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: MaterialButton(
        minWidth: screenWidth,
        onPressed: isQuizStarted ? () => checkAnswer("$optionText") : null,
        color: Colors.green,
        height: screenWidth/10,
        child: AnswerText("$optionText", screenWidth),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}