//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutkart/utils/flutkart.dart';
//import 'package:flutkart/utils/my_navigator.dart';
//
//class SplashScreen extends StatefulWidget {
//  @override
//  _SplashScreenState createState() => _SplashScreenState();
//}
//
//class _SplashScreenState extends State<SplashScreen> {
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    Timer(Duration(seconds: 5), () => MyNavigator.goToIntro(context));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Stack(
//        fit: StackFit.expand,
//        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(color: Colors.redAccent),
//          ),
//          Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Expanded(
//                flex: 2,
//                child: Container(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      CircleAvatar(
//                        backgroundColor: Colors.white,
//                        radius: 50.0,
//                        child: Icon(
//                          Icons.shopping_cart,
//                          color: Colors.greenAccent,
//                          size: 50.0,
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top: 10.0),
//                      ),
//                      Text(
//                        Flutkart.name,
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold,
//                            fontSize: 24.0),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Expanded(
//                flex: 1,
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    CircularProgressIndicator(),
//                    Padding(
//                      padding: EdgeInsets.only(top: 20.0),
//                    ),
//                    Text(
//                      Flutkart.store,
//                      softWrap: true,
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 18.0,
//                          color: Colors.white),
//                    )
//                  ],
//                ),
//              )
//            ],
//          )
//        ],
//      ),
//    );
//  }
//}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.green,
                    size: 50.0,
                  ),
                ),
              ),
            ),
          ),
          RoundedButton(
              title: 'Continue with Google',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/MyHomePage');
              }),
          RoundedButton(
              title: 'Continue with Facebook',
              colour: Colors.lightBlueAccent,
              icon: Icon(
                Icons.face,
                color: Colors.green,
              ),
              onPressed: () {}),
          RoundedButton(
              title: 'Continue with Email',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/MyHomePage');
              }),
          SignInButtonBuilder(
            text: 'Get going with Email',
            icon: Icons.email,
            onPressed: () {},
            backgroundColor: Colors.blueGrey[700],
            width: 200.0,
          ),
        ],
      ),
    );
  }
}
