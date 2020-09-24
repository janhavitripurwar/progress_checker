import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:status_checker/views/createteam.dart';
import 'package:status_checker/views/memberslist.dart';
import 'package:status_checker/widgets/widget.dart';
import 'package:status_checker/services/database.dart';

class myTeamList extends StatefulWidget {
  @override
  _myTeamListState createState() => _myTeamListState();
}

class _myTeamListState extends State<myTeamList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: myTeam(),
    );
  }
}


class myTeam extends StatefulWidget {
  @override
  _myTeamState createState() => _myTeamState();
}

class _myTeamState extends State<myTeam> {

  Future _data;
  Future getPosts() async{
    var firestore = Firestore.instance;
     QuerySnapshot qn = await firestore.collection("Users").getDocuments();
     return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    _data=getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
          child: Text("Loading..."),
          );
      }else {

         return ListView.builder(
             itemCount: snapshot.data.length,
             itemBuilder: (_,index){

               return ListTile(
                 title: Text(snapshot.data[index].data["team"]),
                 onTap: () {
                   //TODO
                   Navigator.pushReplacement(context, MaterialPageRoute(
                     builder: (context) => createTeam()
                   ));
                 }
               );

      });

      }
      }),
    );
  }
}
