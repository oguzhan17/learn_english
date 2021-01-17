import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'quizpage.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<String> images = [
    "https://lh3.googleusercontent.com/-KF90sztNd0Q/X-8DSDWCzWI/AAAAAAABJ0U/8eXpMzbITGkVHOxVR8H67iJGYeULfSiTQCLcBGAsYHQ/s16000/colors.png",
    "https://lh3.googleusercontent.com/-Yw6wkoErTL8/X-8IqEQjC9I/AAAAAAABJ0k/VJNVkItxhwktN4clpT05cAj0Y1FoVsarwCLcBGAsYHQ/s16000/pngegg.png",
    "https://1.bp.blogspot.com/-WLviKrv8zUM/X_tlMsZJTbI/AAAAAAABKGg/6A0vUJrUh-8mRxM-99KLBqX1BZCSvfXeQCLcBGAsYHQ/s320/Fruits.png",
    "https://1.bp.blogspot.com/-Lmh5Q75wKxU/X_uIOrjgLhI/AAAAAAABKR4/OlUWMrjeC_kyLQooL5hF-9ol0V68Jxq7ACLcBGAsYHQ/s0/organ.png",
    "https://1.bp.blogspot.com/-HMMpuveR_1Y/X_uMnyyzrpI/AAAAAAABKUg/EcpY5qrgVAsqolqcxzAgT925ENXVtvqXQCLcBGAsYHQ/s320/meslekler.png"
  ];

  Widget QuizCard(String categName, String image) {
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
          elevation: 10,
          child: Column(
            children: <Widget>[
              Container(
                height: 100.0,
                child: ClipOval(
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      image,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  categName,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz",
          style: TextStyle(
            fontFamily: "Nunito",
              fontSize: 25.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[

          QuizCard("Animals", images[1]),
          QuizCard("Fruits", images[2]),
          QuizCard("Professions", images[4]),
          QuizCard("Colors", images[0]),
          QuizCard("Organs", images[3]),
        ],
      ),
    );
  }
}
