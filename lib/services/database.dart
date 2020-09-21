import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  //signin signup
  getUserByUsername(String username)async{
    return await Firestore.instance.collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }
  getUserByUserEmail(String userEmail)async{
    return await Firestore.instance.collection("users")
        .where("name", isEqualTo: userEmail)
        .getDocuments();
  }
  uploadUserInfo(userMap){
    Firestore.instance.collection("users")
        .add(userMap);
  }
  //my teams
  addDomainAndOwnerIdToTeams(teamAndOwner){
    Firestore.instance.collection('Teams')
    .add(teamAndOwner);
  }
  getDomainByDomainName(String domainName) async{
    return await Firestore.instance.collection('Teams')
    .where('domain',isEqualTo: domainName)
    .getDocuments();
  }
  getTeamNames(String teamId) async{
    return await Firestore.instance.collection('Teams')
    .document(teamId)
    .get();
  }
  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
  addConversationMessages(String chatRoomId, messageMap){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){print(e.toString());
    });
  }
  getConversationMessages(String chatRoomId) async{
    return await Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time",descending: false)
        .snapshots();
  }
  getChatRooms(String userName) async{
    return await Firestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
