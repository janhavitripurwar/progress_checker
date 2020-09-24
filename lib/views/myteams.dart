import 'package:flutter/material.dart';
import 'package:status_checker/modal/user.dart';
import 'package:status_checker/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:status_checker/services/database.dart';

class myTeam extends StatefulWidget {
  @override
  _myTeamState createState() => _myTeamState();
}

class _myTeamState extends State<myTeam> {
  AuthMethods auth = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<Userdata>(
        stream: DatabaseMethods(uid: user.uid).userdata,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Userdata userdata = snapshot.data;
            return Scaffold(
                backgroundColor: Colors.white,
                // ignore: missing_return
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  title: Text('My Teams'),
                ),
                body: Column(
                  children: <Widget>[
                    Card(
                        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.red,
                          ),
                          title: Text(
                            'hello',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w900),
                          ),
                        ))
                  ],
                ));
          }
        });
  }
}
