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
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(passData),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: MyHomePage(
          passData: passData,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  String passData;
  MyHomePage({Key key, @required this.passData})
      : super(key: key);

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
                front: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              GetGrid.fromSnapshot(snapshot[index]).photo),
                          fit: BoxFit.cover)),
                ),
                direction: FlipDirection.HORIZONTAL, // default
                back: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              GetGrid.fromSnapshot(snapshot[index]).photo),
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.dstATop),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          GetGrid.fromSnapshot(snapshot[index]).name,
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                        RaisedButton(
                          child: Text('play'),
                          onPressed: () => _speak(
                              GetGrid.fromSnapshot(snapshot[index]).name),
                        ),
                      ],
                    ),
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
  String photo;
  DocumentReference reference;

  GetGrid.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map["name"] != null),
        assert(map["photo"] != null),
        name = map["name"],
        photo = map["photo"];

  GetGrid.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
