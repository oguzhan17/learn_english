import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String textHeading;
  const HeadingText(this.textHeading);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
      child: Text(
        "$textHeading",
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold),
      ),
    );
  }
}