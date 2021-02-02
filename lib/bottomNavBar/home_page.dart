import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_english/services/advert-service.dart';

import '../second_page.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HomePageState());
  }
}

class HomePageState extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageState> {
  final AdvertService _advertService = AdvertService();

  @override
  void initState() {
    _advertService.showBanner();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("titles")
            .orderBy('title', descending: false)
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
      shrinkWrap: true,
      children:
          snapshot.map<Widget>((data) => buildListItem(context, data)).toList(),
    );
  }

  buildListItem(BuildContext context, DocumentSnapshot data) {
    double widthW = MediaQuery.of(context).size.width;
    final row = GetCard.fromSnapshot(data);
    double txtSize = 15;
    double ingTxtSize = 15;
     if(row.title.length > 15)
       txtSize = row.title.length * 1.0 ;
     if(row.engtitle.length > 15)
       ingTxtSize = row.engtitle.length * 1.0;
    //   txtSize = row.title.length * 1.5;
    // else if(row.title.length > 6)
    //   txtSize = row.title.length * 1.8 ;
    // else
    //   txtSize = 17;

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
            children: [
              Row(
             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: widthW* 0.6,
                    child: Column(
                      children: [
                        Text(
                          row.title,
                          style: TextStyle(
                            fontSize: widthW/txtSize,
                            color: Colors.black,
                            fontFamily: 'Nunito Regular',
                          ),
                        ),
                        Text(
                          "(" +row.engtitle + ")",
                          style: TextStyle(
                            fontSize: widthW/ingTxtSize,
                            color: Colors.black,
                            fontFamily: 'Nunito Regular',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10,top: 5,bottom: 5),
                    child: Container(
                        height: widthW * 0.3,
                        width: widthW * 0.3,
                        child: Image.network(row.photo))
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
