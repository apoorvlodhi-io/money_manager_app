import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:moneymanagerapptest3/screens/my_home_page.dart';
import 'package:moneymanagerapptest3/screens/welcome_screen.dart';

//StatelessWidget
class SplashScreen extends StatefulWidget {
//  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInCheck()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.redAccent,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.green,
                        size: 50.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Money Manager App',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "WASTE NO MONEY!",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class SignInCheck extends StatefulWidget {
  @override
  SignInCheckState createState() {
    return new SignInCheckState();
  }
}

class SignInCheckState extends State<SignInCheck> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoggedIn = false;

  void isSignedIn() async {
    if (await _googleSignIn.isSignedIn()) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn == true ? MyHomePage() : WelcomeScreen();
//    return MyHomePage();
  }
}
