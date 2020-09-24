import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:status_checker/modal/user.dart';

class DatabaseMethods {
  final String uid;

  DatabaseMethods({this.uid}) {}

  //signin signup
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: userEmail)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users")
        .add(userMap);
  }

  //my teams
  addDomainAndOwnerIdToTeams(teamAndOwner) {
    Firestore.instance.collection('Teams')
        .add(teamAndOwner);
  }

  getDomainByDomainName(String domainName) async {
    return await Firestore.instance.collection('Teams')
        .where('domain', isEqualTo: domainName)
        .getDocuments();
  }

  getOwnerByOwnerName(String memberName) async {
    return await Firestore.instance.collection('Teams')
        .where('ownerid', isEqualTo: memberName)
        .getDocuments();
  }

  getTeamNames(String teamId) async {
    return await Firestore.instance.collection('Teams')
        .document(teamId)
        .get();
  }

  Future<void> updateteamusertable(String teamname) async {
    return await Firestore.instance
        .collection('Users')
        .document(uid)
        .setData({'team': teamname, 'username': "yeloo"});
  }

  Userdata _userdatafromsnapshot(DocumentSnapshot snapshot) {
    return Userdata(
        username: snapshot.data['username'], team: snapshot.data['team']);
  }

  Stream<Userdata> get userdata {
    return Firestore.instance
        .collection('Users')
        .document(uid)
        .snapshots()
        .map(_userdatafromsnapshot);
  }
}