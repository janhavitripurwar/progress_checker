import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:status_checker/services/database.dart';
class memlist extends StatefulWidget {
  @override
  _memlistState createState() => _memlistState();
}

class _memlistState extends State<memlist> {
  @override
  Future getPosts() async{
    print(DatabaseMethods.teamname);
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Users").getDocuments();
    return qn.documents;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
        elevation: 5.0,
        backgroundColor: Colors.teal,
      ),
      body: Container(
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
              }
              else {

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_,index){
                      print(snapshot.data[index].data["team"]);

                      if(snapshot.data[index].data["team"]==DatabaseMethods.team) {
                        return ListTile(
                          title: Text(snapshot.data[index].data["username"],),

                        );
                      }

                    });

              }
            }),
      )
    );
  }
  }

