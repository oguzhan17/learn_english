import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_english/second_page.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(body: HomePageState()),
    );
  }
}

class HomePageState extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("titles")
            .orderBy('title', descending: true)
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
    return ListView(
      children:
          snapshot.map<Widget>((data) => buildListItem(context, data)).toList(),
    );
  }

  buildListItem(BuildContext context, DocumentSnapshot data) {
    double widthW = MediaQuery.of(context).size.width;
    final row = GetCard.fromSnapshot(data);
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(passData: row.reference.id),
          ),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width /7),
                    child: Column(
                      children: [
                        Text(
                          row.title,
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontFamily: 'Nunito Regular',
                          ),
                        ),
                        Text(
                          "(" +row.engtitle + ")",
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontFamily: 'Nunito Regular',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                        height: widthW/2.5,
                        width: widthW/2.5,
                        child: Image.network(row.photo)),
                  ),
                ],
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
