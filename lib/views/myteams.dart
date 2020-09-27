import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:status_checker/loading.dart';
import 'package:status_checker/views/createteam.dart';
import 'package:status_checker/views/listmemebers.dart';
import 'package:status_checker/views/memberslist.dart';
import 'package:status_checker/widgets/widget.dart';
import 'package:status_checker/services/database.dart';
import 'package:intl/intl.dart';

class myTeamList extends StatefulWidget {

  @override
  _myTeamListState createState() => _myTeamListState();
}

class _myTeamListState extends State<myTeamList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Teams'),
        elevation: 5.0,
        backgroundColor: Colors.teal,
      ),
      body: myTeam(),
    );
  }
}

class myTeam extends StatelessWidget {

  Future getPosts() async{
    print(DatabaseMethods.teamname);
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Users").getDocuments();
    return qn.documents;
  }
String t;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (_,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child:SpinKitChasingDots(
                  color: Colors.blue,
                  size: 50.0,
                ),
              );
            }else {

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_,index){
                    if (snapshot.data[index].data["uid"]== DatabaseMethods.id) {
                      return Center(
                        child: ListTile(
                            leading: CircleAvatar(
                              foregroundColor: Colors.blue,),
                            title: Text(snapshot.data[index].data["team"],
                            ),
                            onTap: () {
                              DatabaseMethods.team = snapshot.data[index]
                                  .data["team"];
                              t = DatabaseMethods.team;
                              print("team: $t");
                              //navigate to members.dart
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => memlist()
                                  ));

                            }
                        ),
                      );
                    }
                    else{
                      return SizedBox(height: 1.0,);
                    }
                  });

            }
          }),
    );
  }
}




