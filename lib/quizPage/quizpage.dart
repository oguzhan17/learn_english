import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'resultpage.dart';

Random random = new Random();
int randomNumber = random.nextInt(8);

class getjson extends StatelessWidget {

  String categName;

  getjson(this.categName);

  String assettoload;

  setasset() {
    if (categName == "Colors") {
      assettoload = "assets/colors.json";
    } else if (categName == "Animals") {
      assettoload = "assets/animals.json";
    } else if (categName == "Fruits") {
      assettoload = "assets/fruits.json";
    } else if (categName == "Organs") {
      assettoload = "assets/organs.json";
    } else {
      assettoload = "assets/professions.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    // this function is called before the build so that
    // the string assettoload is avialable to the DefaultAssetBuilder
    setasset();
    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Yükleniyor",
              ),
            ),
          );
        } else {
          return quizpage(mydata: mydata);
        }
      },
    );
  }
}

class quizpage extends StatefulWidget {
  final List mydata;

  quizpage({Key key, @required this.mydata}) : super(key: key);

  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {
  final List mydata;

  _quizpageState(this.mydata);

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int totalQues = 0;

  int i = randomNumber;
  bool disableAnswer = false;

  int j = 1;
  int timer = 30;
  String showtimer = "30";
  var random_array;

  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  bool canceltimer = false;

  genrandomarray() {
    var distinctIds = [];
    var rand = new Random();
    for (int i = 0;;) {
      distinctIds.add(rand.nextInt(mydata[1].length));
      random_array = distinctIds.toSet().toList();
      if (random_array.length < mydata[1].length) {
        continue;
      } else {
        break;
      }
    }
  }

  @override
  void initState() {
    starttimer();
    genrandomarray();
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;
    setState(() {
      if (j < mydata[1].length && j < 10) {
        i = random_array[j];
        j++;
      } else {
        marks = (marks / totalQues).ceil() * 10;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;
      btncolor["d"] = Colors.indigoAccent;
      disableAnswer = false;
    });
    starttimer();
  }

  void checkanswer(String k) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      marks = marks + 10;
      totalQues++;
      colortoshow = right;
    } else {
      totalQues++;
      colortoshow = wrong;
    }
    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
      disableAnswer = true;
    });
    Timer(Duration(milliseconds: 500), nextquestion);
  }

  Widget choicebutton(String k) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenHeight * 0.008,
        left: screenWidth * 0.04,
        right: screenWidth * 0.04,
      ),
      child: MaterialButton(
        minWidth: screenWidth,
        height: screenHeight * 0.08,
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold),
          //  maxLines: 1,
        ),
        color: btncolor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  title: Text(
                    "Uyarı",
                  ),
                  content: Text("Quizi bitirmeden çıkamazsın :( "),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Peki :(',
                      ),
                    )
                  ],
                ));
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Text(
                showtimer,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.03,),
                child: Container(
                  height: screenHeight * 0.30,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                      mydata[0][i.toString()],
                    ),
                  )),
                ),
              ),
              AbsorbPointer(
                absorbing: disableAnswer,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choicebutton('a'),
                      choicebutton('b'),
                      choicebutton('c'),
                      choicebutton('d'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
