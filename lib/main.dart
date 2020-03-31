import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moneymanagerapptest3/screens/search_users_screen.dart';
import 'package:moneymanagerapptest3/screens/my_home_page.dart';
import 'package:moneymanagerapptest3/screens/notifications_screen.dart';
import 'package:moneymanagerapptest3/screens/splash_screen.dart';
import 'package:moneymanagerapptest3/screens/about_page.dart';
import 'package:moneymanagerapptest3/screens/login_screen.dart';
import 'package:moneymanagerapptest3/screens/registration_screen.dart';
import 'package:moneymanagerapptest3/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoggedIn = false;

  void isSignedIn() async {
    if (await googleSignIn.isSignedIn()) {
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
    return MaterialApp(
      title: "Money App",
      theme: ThemeData(primarySwatch: Colors.red),
//      initialRoute: SplashScreen.id,
      routes: {
//        SplashScreen.id: (context) => SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MyHomePage.id: (context) => MyHomePage(),
        NotificationScreen.id: (context) => NotificationScreen(),
        AboutPage.id: (context) => AboutPage(),
        //Search User Screen
        SeachAppBarRecipe.id: (context) => SeachAppBarRecipe(),
      },
      home: isLoggedIn == true ? MyHomePage() : SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
//  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
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
