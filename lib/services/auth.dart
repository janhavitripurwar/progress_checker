import 'package:firebase_auth/firebase_auth.dart';
import 'package:status_checker/modal/user.dart';
import 'package:status_checker/services/database.dart';

import 'database.dart';
import 'database.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create object based on firebase

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //signin with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      await DatabaseMethods(uid: firebaseUser.uid)
          .updateusertable('team 1', email);
      DatabaseMethods.id=firebaseUser.uid;
      print(DatabaseMethods.id);
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  //register with email
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      await DatabaseMethods(uid: firebaseUser.uid)
          .updateusertable('team1', email);
      DatabaseMethods.id=firebaseUser.uid;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  //reset password

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
