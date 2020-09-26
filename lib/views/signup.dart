import 'package:flutter/material.dart';
import 'package:status_checker/services/auth.dart';
import 'package:status_checker/views/options.dart';
import 'package:status_checker/widgets/widget.dart';
import 'package:status_checker/services/database.dart';
import 'package:status_checker/helper/helperfunctions.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUp(){
    if(formKey.currentState.validate());
    setState(() {
      isLoading = true;
    });

    Map<String,String>userInfoMap = {
      "name" : userNameTextEditingController.text,
      "email" : emailTextEditingController.text
    };

    HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
    HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);

    authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,
        passwordTextEditingController.text).then((val){
         // print("${val.uid}");
      databaseMethods.uploadUserInfo(userInfoMap);
      HelperFunctions.saveUserLoggedInSharedPreference(true);

          Navigator.pushReplacement(context, MaterialPageRoute(
            builder:(context) => option()
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.teal,

      appBar: AppBar(
        title: Text("Register"),
      ),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key:  formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val){
                          return val.isEmpty || val.length<4 ? "Please provide username length > 4":null;
                        },
                        controller: userNameTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration('username'),
                      ),
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)? null : "Please provide valid email id";
                        },
                        controller: emailTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration('email'),
                      ),
                      TextFormField(
                          obscureText: true,
                        validator: (val){
                          return val.length > 6 ? null :"Password length should be greater than 6";
                        },
                          controller: passwordTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration('password')
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Text('Forget Password?',style: simpleTextStyle(),),
                  ),
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: (){
                    signMeUp();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xff007EF4),
                              const Color(0xff2A75BC),
                            ]
                        ),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('Sign Up',style: mediumTextStyle(),),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account? ", style: mediumTextStyle()),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Sign In now", style: TextStyle(
                            color : Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline
                        )),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 160,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
