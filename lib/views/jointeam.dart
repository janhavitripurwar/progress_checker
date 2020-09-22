import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:status_checker/services/database.dart';
import 'package:status_checker/views/myteams.dart';
import 'package:status_checker/widgets/widget.dart';
import 'package:status_checker/views/signin.dart';

class joinTeam extends StatefulWidget {
  @override
  _joinTeamState createState() => _joinTeamState();
}

class _joinTeamState extends State<joinTeam> {
  TextEditingController joinTeamTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appBarMain(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300.0,
              child: TextFormField(
                controller: joinTeamTextEditingController,
                decoration: textFieldInputDecoration('Team Name'),
                style: simpleTextStyle(),
              ),
            ),
            SizedBox(height: 75,),
            RaisedButton(
              onPressed: () async {
               // uploadInfo();
                //TODO
                final ConfirmAction action = await _asyncConfirmDialog(context);
                print("Confirm Action $action" );
              },
              child: const Text(
                "Join Team",
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