import 'package:flutter/material.dart';
import 'package:status_checker/views/options.dart';
import 'package:status_checker/helper/authenticate.dart';
import 'package:status_checker/helper/helperfunctions.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn=false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (userIsLoggedIn==null) ? option() : Authenticate(),
    );
  }
}

