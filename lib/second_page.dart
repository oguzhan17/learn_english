import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Second")
              .orderBy('name', descending: true)
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
          }),
    );
  }

  Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {

    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
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
                            image: DecorationImage(
                                image: NetworkImage(
                                    GetGrid.fromSnapshot(snapshot[index])
                                        .photo),
                                fit: BoxFit.cover)),
                      ),
                      direction: FlipDirection.HORIZONTAL, // default
                      back: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    GetGrid.fromSnapshot(snapshot[index])
                                        .photo),
                                fit: BoxFit.cover)),
                        child: Center(
                            child: Text(
                                GetGrid.fromSnapshot(snapshot[index]).name,style: TextStyle(fontSize: 40,color: Colors.white),),),
                      )),
                ),
              ),
            ),
          );
        });
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
