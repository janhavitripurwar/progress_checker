import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:status_checker/views/progress.dart';
import 'package:status_checker/widgets/widget.dart';
import 'package:status_checker/services/database.dart';

class members extends StatefulWidget {
  @override
  _membersState createState() => _membersState();
}

class _membersState extends State<members> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController memberNameTextEditingController = new TextEditingController();
  QuerySnapshot searchSnapshot;

  initiateMemberSearch (){
    databaseMethods
        .getOwnerByOwnerName(memberNameTextEditingController.text)
        .then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchMemberList(){
    return searchSnapshot !=null ? ListView.builder(
        itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return SearchMemberTile(
            memberName: searchSnapshot.documents[index].data["ownerid"],
            //userEmail: searchSnapshot.documents[index].data["email"],
          );
        }) : Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members List'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: memberNameTextEditingController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "search member...",
                            hintStyle: TextStyle(
                                color: Colors.white54
                            ),
                            border: InputBorder.none
                        ),
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateMemberSearch();
                    },
                    child: Container(
                      height: 50,
                      width: 60,
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF)
                              ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: Image.asset("assests/images/search.png"),
                    ),
                  ),
                ],
              ),
            ),
            searchMemberList()
          ],
        ),
      ),
    );
  }
}
class SearchMemberTile extends StatelessWidget {
  final String memberName;
  SearchMemberTile({this.memberName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 46),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(memberName,style: mediumTextStyle()),

            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => checkProgress()
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Text('check Progress',style: mediumTextStyle(),),
            ),
          )
        ],
      ),
    );
  }
}
