import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_english/components/AnswerButton.dart';
import 'package:learn_english/components/HeadingText.dart';
import 'package:learn_english/components/QuestionText.dart';
import 'package:lottie/lottie.dart';

import '../ques.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void initState() {
    super.initState();
    start_quiz();
  }

  int currentIndex;
  int totalQues = QUES.length;
  int solvedQues = 1;
  String nextQue = "";
  String quiz_status = "YENİDEN BAŞLA";
  String score = "";
  String op1, op2, op3, op4, answer;
  int finalScore = 0;
  List<int> solvedQuesIndexes = [];

  bool isVisible = true;

  void check_ans(String value) {
    setState(() {
      solvedQues += 1;
      if (value == answer) {
        finalScore += 1;
      }
      if (solvedQues - 1 == totalQues) {
        isVisible = false;
        score = "Skor : $finalScore/$totalQues";
      } else {
        var index = Random().nextInt(QUES.length);
        while (solvedQuesIndexes.contains(index)) {
          index = Random().nextInt(QUES.length);
        }
        solvedQuesIndexes.add(index);
        List<String> ans = QUES[index]['answers'];
        nextQue = QUES[index]['question'];
        op1 = ans[0];
        op2 = ans[1];
        op3 = ans[2];
        op4 = ans[3];
        answer = ans[QUES[index]['correctIndex']];
      }
    });
  }

  void start_quiz() {
    setState(() {
      isVisible = true;
      finalScore = 0;
      solvedQues = 1;
      score = "";
      solvedQuesIndexes = [];

      var index = Random().nextInt(QUES.length);
      while (solvedQuesIndexes.contains(index)) {
        index = Random().nextInt(QUES.length);
      }
      solvedQuesIndexes.add(index);
      List<String> ans = QUES[index]['answers'];
      nextQue = QUES[index]['question'];
      op1 = ans[0];
      op2 = ans[1];
      op3 = ans[2];
      op4 = ans[3];
      answer = ans[QUES[index]['correctIndex']];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Visibility(
                    visible: isVisible,
                    child: HeadingText(
                      "Soru : $solvedQues / $totalQues".toUpperCase(),
                    ),
                  ),
                  Visibility(
                      visible: isVisible,
                      child: QuestionText("$nextQue", screen_width)),
                  //Answer Button
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: <Widget>[
                        AnswerButton(op1, isVisible, check_ans, screen_width),
                        AnswerButton(op2, isVisible, check_ans, screen_width),
                        AnswerButton(op3, isVisible, check_ans, screen_width),
                        AnswerButton(op4, isVisible, check_ans, screen_width),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !isVisible,
                        child: Container(
                          width: screen_width,
                          child: Lottie.asset('assets/lottie/confetti.json',
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                      Text(
                        score,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: ('Nunito'),
                        ),
                      ),
                      Visibility(
                        visible: !isVisible,
                        child: MaterialButton(
                          onPressed: () => start_quiz(),
                          color: Colors.green[800],
                          height: 50.0,
                          child: Text(
                            "$quiz_status",
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontFamily: ('Nunito')),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
