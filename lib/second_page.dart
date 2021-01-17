import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SecondPage extends StatelessWidget {
  String passData;
  SecondPage({Key key, @required this.passData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            passData,
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: MyHomePage(
          passData: passData,
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String passData;
  MyHomePage({Key key, @required this.passData}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(passData);
}

class _MyHomePageState extends State<MyHomePage> {
  String passData;
  final FlutterTts flutterTts = FlutterTts();
  _MyHomePageState(this.passData);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(passData)
            .orderBy('name', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return buildBody(context, snapshot.data.docs);
          }
        });
  }

  Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    Future _speak(String speakText) async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.speak(speakText);
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      children: List.generate(
        snapshot.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                              image: NetworkImage(
                              GetGrid.fromSnapshot(snapshot[index]).photo),
                          fit: BoxFit.scaleDown)),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(GetGrid.fromSnapshot(snapshot[index]).isim,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                back: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              GetGrid.fromSnapshot(snapshot[index]).photo),
                          fit: BoxFit.scaleDown),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          color: Colors.transparent,
                          height: 40.0,
                          child: IconButton(
                            icon: Icon(Icons.volume_up),
                            onPressed: () => _speak( GetGrid.fromSnapshot(snapshot[index]).name),
                          )
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.lightGreen[200].withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            GetGrid.fromSnapshot(snapshot[index]).name,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class GetGrid {
  String name;
  String isim;
  String photo;
  DocumentReference reference;

  GetGrid.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map["name"] != null),
        assert(map["isim"] != null),
        assert(map["photo"] != null),
        name = map["name"],
        isim = map["isim"],
        photo = map["photo"];

  GetGrid.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
