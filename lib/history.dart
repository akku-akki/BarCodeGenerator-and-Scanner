import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("data").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError)
              return Text("Error");
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            if(snapshot.hasData)
              return
                ListView(
                  children:
                    snapshot.data.documents.map((DocumentSnapshot document){
                      return Container(
                       color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Text("Qr for ${document["data_name"]}"),
                            SizedBox(height: 5,),
                            Center(
                              child: QrImage(
                                data: "${document["data_name"]}",
                                size: 200,
                              ),
                            ),
                            SizedBox(height: 8,),
                          ],
                        ),
                      );
                    }).toList()

                );

          },
        ),
      )
    );
  }
}