import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class members extends StatefulWidget {
  @override
  _membersState createState() => _membersState();
}

class _membersState extends State<members> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members',style: TextStyle(
          fontSize: 22
        ),),
//      ),
//      body: StreamBuilder(
//        stream: Firestore.instance.collection('Teams').snapshots(),
//          builder: (context,snapshot){
//          if(!snapshot.hasData)  return Text('Data is loading....please wait');
//          return Column(
//            children: <Widget>[
//              Text(snapshot.data.documents[0]['users'])
//            ],
//          );
//          },
//      ),
    )
    );
  }
}
