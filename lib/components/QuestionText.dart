import 'package:flutter/material.dart ';

class QuestionText extends StatelessWidget {
  final String textQuestion;
  final double screenWidth;
  const QuestionText(this.textQuestion,this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      margin: EdgeInsets.all(10),
      width: screenWidth,
      child: Image.network(
        "$textQuestion",
      ),
    );
  }
}