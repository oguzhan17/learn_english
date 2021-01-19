import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../quizPage/quizpage.dart';

class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  List<String> images = [
    "https://lh3.googleusercontent.com/-KF90sztNd0Q/X-8DSDWCzWI/AAAAAAABJ0U/8eXpMzbITGkVHOxVR8H67iJGYeULfSiTQCLcBGAsYHQ/s16000/colors.png",
    "https://lh3.googleusercontent.com/-Yw6wkoErTL8/X-8IqEQjC9I/AAAAAAABJ0k/VJNVkItxhwktN4clpT05cAj0Y1FoVsarwCLcBGAsYHQ/s16000/pngegg.png",
    "https://1.bp.blogspot.com/-WLviKrv8zUM/X_tlMsZJTbI/AAAAAAABKGg/6A0vUJrUh-8mRxM-99KLBqX1BZCSvfXeQCLcBGAsYHQ/s320/Fruits.png",
    "https://1.bp.blogspot.com/-Lmh5Q75wKxU/X_uIOrjgLhI/AAAAAAABKR4/OlUWMrjeC_kyLQooL5hF-9ol0V68Jxq7ACLcBGAsYHQ/s0/organ.png",
    "https://1.bp.blogspot.com/-HMMpuveR_1Y/X_uMnyyzrpI/AAAAAAABKUg/EcpY5qrgVAsqolqcxzAgT925ENXVtvqXQCLcBGAsYHQ/s320/meslekler.png"
  ];

  Widget quizCard(String categName, String image) {

    double widthH = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: MediaQuery.of(context).size.width / 20,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => getjson(categName),
            ),
          );
        },
        child: Material(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: widthH / 15),
                    child: Column(
                      children: [
                        Text(
                          categName,
                          style: TextStyle(
                            fontSize: widthH/13,
                            fontFamily: 'Nunito Regular',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      height: 120,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double heightH = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz",
          style: TextStyle(
              fontFamily: "Nunito",
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          quizCard("Animals", images[1]),
          quizCard("Fruits", images[2]),
          quizCard("Professions", images[4]),
          quizCard("Colors", images[0]),
          quizCard("Organs", images[3]),
        ],
      ),
    );
  }
}
