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
  bool visBool = false;
  bool soruVisibility = true;
  void initState() {
    super.initState();
    start_quiz();
  }

  int totalQues = 3;
  int solvedQues = 1;
  String nextQue = "";
  String quiz_status = "YENİDEN BAŞLA";
  String score = "";
  String op1, op2, op3, op4, answer;
  bool isQuizStarted = false;
  int finalScore = 0;
  List<int> solvedQuesIndexes = [];
  bool isLottieVisib = false;
  bool isRestartVisib = false;
  bool isQuesVisib = true;
  bool isAnsVisib = true;

  void check_ans(String value) {
    setState(() {
      solvedQues += 1;
      if (value == answer) {
        finalScore += 1;
      }
      if (solvedQues - 1 == totalQues) {
        visBool = true;
        soruVisibility = false;
        isQuizStarted = false;
        score = "Skor : $finalScore/$totalQues";
        isLottieVisib = true;
        isRestartVisib = true;
        isAnsVisib = false;
        isRestartVisib = true;
        isQuesVisib = false;
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
      soruVisibility = true;
      visBool = false;
      finalScore = 0;
      solvedQues = 1;
      isQuizStarted = true;
      score = "";
      solvedQuesIndexes = [];
      isLottieVisib = false;

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
                    visible: soruVisibility,
                    child: HeadingText(
                      "Soru : $solvedQues / $totalQues".toUpperCase(),
                    ),
                  ),
                  Visibility(
                      visible: isQuesVisib,
                      child: QuestionText("$nextQue", screen_width)),
                  //Answer Button
                  Visibility(
                    visible: isAnsVisib,
                    child: Column(
                      children: <Widget>[
                        AnswerButton(
                            op1, isQuizStarted, check_ans, screen_width),
                        AnswerButton(
                            op2, isQuizStarted, check_ans, screen_width),
                        AnswerButton(
                            op3, isQuizStarted, check_ans, screen_width),
                        AnswerButton(
                            op4, isQuizStarted, check_ans, screen_width),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: isLottieVisib,
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
                        visible: isRestartVisib,
                        child: MaterialButton(
                          onPressed:(){ Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuizPage()),
                          );},
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
