import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:status_checker/views/memberslist.dart';
import 'package:status_checker/widgets/widget.dart';
import 'package:status_checker/services/database.dart';

class myTeam extends StatefulWidget {
  @override
  _myTeamState createState() => _myTeamState();
}

class _myTeamState extends State<myTeam> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController teamNameTextEditingController =
      new TextEditingController();
  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getDomainByDomainName(teamNameTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                teamName: searchSnapshot.documents[index].data["domain"],
                //userEmail: searchSnapshot.documents[index].data["email"],
              );
            })
        : Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Teams'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: teamNameTextEditingController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      height: 50,
                      width: 60,
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color(0x36FFFFFF),
                            const Color(0x0FFFFFFF)
                          ]),
                          borderRadius: BorderRadius.circular(40)),
                      child: Image.asset("assests/images/search.png"),
                    ),
                  ),
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String teamName;

  SearchTile({this.teamName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 46),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(teamName, style: mediumTextStyle()),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => members()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(40)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                'Members',
                style: mediumTextStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
