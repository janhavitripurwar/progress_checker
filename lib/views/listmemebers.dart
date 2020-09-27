import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:status_checker/services/database.dart';
class memlist extends StatefulWidget {
  @override
  _memlistState createState() => _memlistState();
}

class _memlistState extends State<memlist> {

  DateTime _dateTime;
  DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
  int deadline=0;

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
                        if (deadline <= 0) {
                          return ListTile(
                            leading:
                            CircleAvatar(
                              backgroundColor: Colors.red,),
                            title: Text(snapshot.data[index].data["username"],),

                          );
                        }
                        else{
                          return ListTile(
                            leading:
                            CircleAvatar(
                              backgroundColor: Colors.blue,),
                            title: Text(snapshot.data[index].data["username"],),

                          );
                        }

                      }
                      else{
                        return SizedBox(height: 1.0,);
                      }

                    });

              }
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDatePicker(
              context: context,
              initialDate: _dateTime == null? DateTime.now() : _dateTime,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030)
          ).then((date){
            setState(() {
              _dateTime = date;
              print(_dateTime==null ?"nothing has been picked" : _dateTime.toString());
              print(dateToday.toString());
              deadline=_dateTime.toString().compareTo(dateToday.toString());
              DatabaseMethods(uid: DatabaseMethods.id).updateusertable(DatabaseMethods.team,DatabaseMethods.uname,_dateTime.toString());
            });
          });
        },
        label: Text('Set Deadline'),
        icon: Icon(Icons.date_range),
      ),
    );
  }
  }

