import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:status_checker/services/database.dart';
import 'package:status_checker/views/myteams.dart';
import 'package:status_checker/widgets/widget.dart';
import 'package:status_checker/views/signup.dart';

class joinTeam extends StatefulWidget {
  @override
  _joinTeamState createState() => _joinTeamState();
}

class _joinTeamState extends State<joinTeam> {
  TextEditingController usernameTextEditingController = new TextEditingController();
  TextEditingController joinTeamTextEditingController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();


  pplArray() async{
    DocumentReference docRef = Firestore.instance.collection('Team').document(joinTeamTextEditingController.text);
    DocumentSnapshot doc = await docRef.get();
    List ppl = doc.data["ppl"];
    docRef.updateData(
        {
          'ppl' : FieldValue.arrayUnion([DatabaseMethods.id])
        }
    );
  }
String _teamname;
  String _username;
  @override
  Widget build(BuildContext context) {



    return Scaffold(


      appBar:  AppBar(
        title: Text('Join a Team'),
        elevation: 5.0,
        backgroundColor: Colors.green,
      ),
      body:


      Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(

              width: 300.0,
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameTextEditingController,
                    style: TextStyle(color: Colors.black),
                    decoration:  InputDecoration(hintText: 'Username',fillColor: Colors.white70,filled: true,
                        enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.blue ,
                            width: 2.0)) ),
                  ),

                  SizedBox(height: 20.0,),
                  TextFormField(
                    controller: joinTeamTextEditingController,
                    style: TextStyle(color: Colors.black),
                    decoration:  InputDecoration(hintText: 'Team Name',fillColor: Colors.white70,filled: true,
                        enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.blue ,
                            width: 2.0)) ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 75,),
            RaisedButton(
              onPressed: () async {

                _teamname=joinTeamTextEditingController.text;
                _username=usernameTextEditingController.text;
                print(_teamname);
                DatabaseMethods.uname=_username;
                DatabaseMethods(uid: DatabaseMethods.id).updateusertable(_teamname, _username,"2020-01-01 00:00:00.000");

               pplArray();
                final ConfirmAction action = await _asyncConfirmDialog(context);
                print("Confirm Action $action" );

              },
              child: const Text(
                "Join Team",
                style: TextStyle(fontSize: 30.0,color: Colors.white),),
              padding: EdgeInsets.fromLTRB(30.0,10.0,30.0,10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
              color: Colors.green,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

enum ConfirmAction { Cancel, Accept}
Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Team Created Successfully!', style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),),
        content: Icon(
          Icons.check_circle,
          size: 42,
          color: Colors.green,
        ),
        actions: <Widget>[
          FlatButton(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC),
                      ]
                  ),
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Text('My Teams',style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              )),

            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => myTeamList()
              ));
            },
          ),
        ],
      );
    },
  );
}