import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moneymanagerapptest3/screens/my_home_page.dart';
import 'package:moneymanagerapptest3/screens/notifications_screen.dart';
import 'package:moneymanagerapptest3/screens/splash_screen.dart';
import 'package:moneymanagerapptest3/screens/about_page.dart';
import 'package:moneymanagerapptest3/screens/login_screen.dart';
import 'package:moneymanagerapptest3/screens/registration_screen.dart';
import 'package:moneymanagerapptest3/screens/welcome_screen.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      initialRoute: SplashScreen.id,
//      routes: {
//        SplashScreen.id: (context) => SplashScreen(),
//        WelcomeScreen.id: (context) => WelcomeScreen(),
//        LoginScreen.id: (context) => LoginScreen(),
//        RegistrationScreen.id: (context) => RegistrationScreen(),
//        MyHomePage.id: (context) => MyHomePage(),
//        NotificationScreen.id: (context) => NotificationScreen(),
//        AboutPage.id: (context) => AboutPage(),
//      },
//    );
//  }
//}

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      },
      home: isLoggedIn == true ? MyHomePage() : WelcomeScreen(),
    );
  }
}
