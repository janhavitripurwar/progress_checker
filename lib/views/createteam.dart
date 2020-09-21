import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:status_checker/services/database.dart';
import 'package:status_checker/views/myteams.dart';
import 'package:status_checker/widgets/widget.dart';

class createTeam extends StatefulWidget {
  @override
  _createTeamState createState() => _createTeamState();
}

TextEditingController teamNameTextEditingController = new TextEditingController();
class _createTeamState extends State<createTeam> {

  DatabaseMethods databaseMethods = new DatabaseMethods();


  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController userNameTextEditingController = new TextEditingController();



  uploadInfo() async{
    Map<String,String>teamAndOwnerInfo = {
      'domain' : teamNameTextEditingController.text,
      //'ownerid' : emailTextEditingController.text
    };

    //databaseMethods.addDomainAndOwnerIdToTeams(teamAndOwnerInfo);
    final databaseReference = Firestore.instance;
    databaseReference.collection('Teams')
        .document().collection(teamNameTextEditingController.text)
        .document().collection(userNameTextEditingController.text)
        .document().setData(teamAndOwnerInfo);// your answer missing **.document()**  before setData
    //TODO

    final ConfirmAction action = await _asyncConfirmDialog(context);
    print("Confirm Action $action" );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300.0,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: userNameTextEditingController,
                    decoration: textFieldInputDecoration('username'),
                    style: simpleTextStyle(),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: teamNameTextEditingController,
                    decoration: textFieldInputDecoration('Team Name'),
                    style: simpleTextStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 75,),
            RaisedButton(
              onPressed: () async {
                uploadInfo();
              },
              child: const Text(
                "Create Team",
                style: TextStyle(fontSize: 30.0),),
              padding: EdgeInsets.fromLTRB(30.0,10.0,30.0,10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
              color: Colors.pinkAccent,
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xff1F1F1F),
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
              print(teamNameTextEditingController.text);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => myTeam()
              ));
            },
          ),
        ],
      );
    },
  );
}