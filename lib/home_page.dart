import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_english/second_page.dart';


double cardHeight = 200.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("titles")
                  .orderBy('title', descending: true)
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return buildBody(context, snapshot.data.docs);
                }
              }
      ),
    );
  }

  Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children:
      snapshot.map<Widget>((data) => buildListItem(context, data)).toList(),
    );
  }

  buildListItem(BuildContext context, DocumentSnapshot data) {
    double widthW = MediaQuery.of(context).size.width;
    final row = GetCard.fromSnapshot(data);
    return InkWell(
      onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SecondPage()
      ),
    ),
      child: Container(
        height: cardHeight,
        width: double.maxFinite,
        child: Card(
          elevation: 5,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: cardHeight / 2,
                child: Row(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            row.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        Text(
                          "(" + row.engtitle + ")",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: Image.network(row.photo),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetCard {
  String title;
  String photo;
  String engtitle;
  String className;
  DocumentReference reference;

  GetCard.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map["title"] != null),
        assert(map["photo"] != null),
        assert(map["engtitle"] != null),
        photo = map["photo"],
        engtitle = map["engtitle"],
        title = map["title"];

  GetCard.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
