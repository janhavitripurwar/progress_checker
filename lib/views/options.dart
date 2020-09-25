import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:status_checker/helper/authenticate.dart';
import 'package:status_checker/views/createteam.dart';
import 'package:status_checker/views/jointeam.dart';
import 'package:status_checker/views/myteams.dart';
import 'package:status_checker/widgets/widget.dart';
import 'package:status_checker/services/auth.dart';

import '../services/database.dart';


class option extends StatelessWidget {

  AuthMethods authMethods = new AuthMethods();
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    print(DatabaseMethods.id);
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                authMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        body: MyStatelessWidget(),

        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(DatabaseMethods.id);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => createTeam()
              ));
            },
            child: const Text('Create Team', style: TextStyle(fontSize: 30,)),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
          ),
          const SizedBox(height: 40),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => joinTeam()
              ));
            },
            child: const Text('Join Team', style: TextStyle(fontSize: 30)),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
          ),
          const SizedBox(height: 40),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => myTeamList()
              ));
            },
              child:
              const Text('My Teams', style: TextStyle(fontSize: 30)),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
        ],
      ),
    );
  }
}
