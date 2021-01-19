import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<ItemModel> items;
  int score;
  bool gameOver;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(
          name: "Walk",
          value: "Walk",
          lottie: 'assets/lottie/walking.json'),
      ItemModel(
          name: "Sing",
          value: "Sing",
          lottie: 'assets/lottie/singing.json'),
      ItemModel(
          name: "Ride",
          value: "Ride",
          lottie: 'assets/lottie/riding.json'),
      ItemModel(
          name: "Write",
            value: "Write",
          lottie: 'assets/lottie/writing.json'),
      ItemModel(
          name: "Run",
          value: "Run",
          lottie: 'assets/lottie/running.json'),
      ItemModel(
          name: "Drive",
          value: "Drive",
          lottie: 'assets/lottie/driving.json'),
      ItemModel(
          name: "Sleep",
          value: "Sleep",
          lottie: 'assets/lottie/sleeping.json'),
      ItemModel(
          name: "Cry",
          value: "Cry",
          lottie: 'assets/lottie/crying.json'),
      ItemModel(
          name: "Swim",
          value: "Swim",
          lottie: 'assets/lottie/swimming.json'),
      ItemModel(
          name: "Laugh",
          value: "Laugh",
          lottie: 'assets/lottie/laughing.json'),
      ItemModel(
          name: "Jump",
          value: "Jump",
          lottie: 'assets/lottie/jumping.json'),
    ];
    items.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    if (items.length == 0) gameOver = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sürükle & Bırak',
          style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    title: Text(
                      'Fiillerin Anlamları',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                        'Walk : Yürümek\n'
                            'Run : Koşmak\n'
                            'Drive : Araba sürmek\n'
                            'Ride : Bisiklet sürmek\n'
                            'Sing : Şarkı söylemek\n'
                            'Write : Yazı yazmak\n'
                            'Jump : Zıplamak\n'
                            'Laugh : Gülmek\n'
                            'Cry : Ağlamak\n'
                            'Swim : Yüzmek\n'
                            'Sleep : Uyumak',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20
                    ),),
                  ),
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'Score : ',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.blue,
                          fontFamily: 'Nunito')),
                  TextSpan(
                    text: '$score',
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Column(
                    children: items
                        .map((item) {
                          return Container(
                            height: h / 6,
                            width: w / 3,
                            child: Draggable<ItemModel>(
                                data: item,
                                feedback: Container(
                                    height: h / 6,
                                    width: w / 3,
                                    child: Lottie.asset(item.lottie)),
                                child: Container(
                                    height: h / 6,
                                    width: w / 3,
                                    child: Lottie.asset(item.lottie))),
                          );
                        })
                        .take(4)
                        .toList()),
                Spacer(),
                Column(
                    children: items
                        .map((item) {
                          return DragTarget<ItemModel>(
                            onAccept: (receivedItem) {
                              if (item.value == receivedItem.value) {
                                setState(() {
                                  items.remove(receivedItem);
                                  items.remove(item);
                                  score += 10;
                                  item.accepting = true;
                                });
                              } else {
                                setState(() {
                                  score -= 5;
                                  item.accepting = false;
                                });
                              }
                            },
                            builder: (context, acceptedItems, rejectedItems) =>
                                Container(
                              height: h / 12,
                              width: w / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: item.accepting
                                    ? Colors.lightGreen
                                    : Colors.green,
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: w / 15),
                              child: Text(
                                item.name,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontFamily: 'Nunito'),
                              ),
                            ),
                          );
                        })
                        .take(4)
                        .toList()
                          ..shuffle()),
              ],
            ),
            if (gameOver)
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      textColor: Colors.white,
                      color: Colors.pink,
                      child: Text(
                        'Yeniden Başla!',
                        style: TextStyle(fontFamily: 'Nunito', fontSize: 25),
                      ),
                      onPressed: () {
                        initGame();
                        setState(() {});
                      }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  final String name;
  final String value;
  final String lottie;
  bool accepting;

  ItemModel({this.name, this.value, this.lottie, this.accepting = false});
}
