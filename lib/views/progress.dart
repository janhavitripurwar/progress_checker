import 'package:flutter/material.dart';
import 'package:status_checker/widgets/widget.dart';
import 'package:status_checker/services/database.dart';

class checkProgress extends StatefulWidget {
  @override
  _checkProgressState createState() => _checkProgressState();
}
class _checkProgressState extends State<checkProgress> {
  TextEditingController taskTextEditingController = new TextEditingController();

  DatabaseMethods databaseMethods = new DatabaseMethods();

  addTask() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Add task description"),
          content: TextFormField(
            controller: taskTextEditingController,
            //decoration: textFieldInputDecoration('description'),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Add"),
              onPressed: () {
                addTaskToList();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addTask();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
class addTaskToList extends StatelessWidget {
  final String task;
  addTaskToList({this.task});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
              leading: Icon(Icons.wb_sunny),
              trailing: Text(task),
            );
          }
      ),
    );
  }
}
