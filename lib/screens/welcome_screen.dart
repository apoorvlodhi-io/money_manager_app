import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:moneymanagerapptest3/screens/my_home_page.dart';

import 'package:moneymanagerapptest3/components/user_details.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:moneymanagerapptest3/screens/registration_screen.dart';
import 'package:moneymanagerapptest3/components/welcome_screen_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  DocumentReference _documentReference;
  UserDetails _userDetails = UserDetails();
  var mapData = Map<String, String>();
  String uid;

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: _signInAuthentication.idToken,
        accessToken: _signInAuthentication.accessToken);

//    FirebaseUser user =
//        await _firebaseAuth.signInWithCredential(authCredential);
//    return user;
    print('APOORV LODHI HOME PAGE');
    FirebaseUser user =
        (await _firebaseAuth.signInWithCredential(authCredential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  void addDataToDb(FirebaseUser user) {
    _userDetails.name = user.displayName;
    _userDetails.emailId = user.email;
    _userDetails.photoUrl = user.photoUrl;
    _userDetails.uid = user.uid;
    mapData = _userDetails.toMap(_userDetails);

    uid = user.uid;

    _documentReference = Firestore.instance.collection("users").document(uid);

    _documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        _documentReference.setData(mapData).whenComplete(() {
          print("Users Colelction added to Database");
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => MyHomePage()));
        }).catchError((e) {
          print("Error adding collection to Database $e");
        });
      }
    });
  }

  _launchUrl(String url) {
    canLaunch(url).then((bool success) {
      if (success) {
        launch(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Column(
            children: <Widget>[
              WelcomeScreenButton(
                title: 'Continue with Google',
                colour: Colors.white,
                backgroundImage: Image.asset('assets/google_logo.png'),
//                backgroundImage: Image.network(
//                    'https://pngimg.com/uploads/google/google_PNG19635.png'),
//                onPressed: () => authService.googleSignIn(),
                onPressed: () {
                  signIn().then((FirebaseUser user) {
                    addDataToDb(user);
                  });
                },
              ),
              WelcomeScreenButton(
                  title: 'Continue with Facebook',
                  colour: Colors.white,
                  backgroundImage: Image.asset('assets/Facebook_Logo.png'),
//                  backgroundImage: Image.network(
//                      'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png'),
                  onPressed: () {}),
              WelcomeScreenButton(
                title: 'Continue with Email',
                colour: Colors.white,
                backgroundImage: Image.asset('assets/email_logo.png'),
//                backgroundImage: Image.network(
//                    'https://lh3.googleusercontent.com/YTB4ZfOQpnJUB4F1G7GCoc8J0Y3xfEyLEs07vUotIz6WDkQ1jGIhqmAfnYHICg3NAyI'),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
//                            color:
//                                darkText.withOpacity(darkText.opacity * 0.75),
                            color: Colors.black,
//                            fontFamily: "Roboto",
                            fontSize: 10.0,
                            height: 1.5),
                        children: [
                          TextSpan(
                            text: 'By Continuing, you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchUrl(
                                  "https://github.com/apoorvlodhi-io/money_manager_app/blob/master/README.md"),
                          ),
                          TextSpan(
                            text: ' and ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchUrl(
                                  "https://github.com/apoorvlodhi-io/money_manager_app/blob/master/README.md"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
