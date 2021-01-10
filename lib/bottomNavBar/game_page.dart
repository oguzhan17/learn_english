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
          name: "Walking",
          value: "Walking",
          lottie: 'assets/lottie/walking.json'),
      ItemModel(
          name: "Singing",
          value: "Singing",
          lottie: 'assets/lottie/singing.json'),
      ItemModel(
          name: "Riding",
          value: "Riding",
          lottie: 'assets/lottie/riding.json'),
      ItemModel(
          name: "Writing",
          value: "Writing",
          lottie: 'assets/lottie/writing.json'),
      ItemModel(
          name: "Running",
          value: "Running",
          lottie: 'assets/lottie/running.json'),
      ItemModel(
          name: "Driving",
          value: "Driving",
          lottie: 'assets/lottie/driving.json'),
    ];
    items.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    if(items.length == 0)
      gameOver = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sürükle & Bırak',
          style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
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
                    children: items.map((item) {
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
                }).take(4).toList()),
                Spacer(),
                Column(
                    children: items.map((item) {
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
                        color:
                            item.accepting ? Colors.lightGreen : Colors.green,
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
                }).take(4).toList()..shuffle()
                ),
              ],
            ),
            if(gameOver)
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  textColor: Colors.white,
                  color: Colors.pink,
                  child: Text('Yeniden Başla!',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 25
                  ),),
                    onPressed: (){
                    initGame();
                    setState(() {
                    });
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
