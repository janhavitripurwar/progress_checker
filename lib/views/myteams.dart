import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
//
//  @override
//  void initState() {
//   // super.initState();
//    _data=getPosts();
//  }

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

                    return ListTile(
                        title: Text(snapshot.data[index].data["team"],
                          ),
                        onTap: () {
                          //navigate to members.dart
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



//class myTeam extends StatefulWidget {
//  @override
//  _myTeamState createState() => _myTeamState();
//}
//
//class _myTeamState extends State<myTeam> {
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: FutureBuilder(
//          future: _data,
//          builder: (_,snapshot){
//        if(snapshot.connectionState == ConnectionState.waiting){
//          return Center(
//          child:SpinKitChasingDots(
//            color: Colors.blue,
//            size: 50.0,
//          ),
//          );
//      }else {
//
//         return ListView.builder(
//             itemCount: snapshot.data.length,
//             itemBuilder: (_,index){
//
//               return ListTile(
//                 title: Text(snapshot.data[index].data["team"]),
//                 onTap: () {
//                   //navigate to members.dart
//                   Navigator.pushReplacement(context, MaterialPageRoute(
//                     builder: (context) => createTeam()
//                   ));
//                 }
//               );
//
//      });
//
//      }
//      }),
//    );
//  }
//}
