import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:share/share.dart";

import 'package:moneymanagerapptest3/components/expenditure_tab.dart';
import 'package:moneymanagerapptest3/components/main_menu.dart';
import 'package:moneymanagerapptest3/components/user_list.dart';
import 'package:moneymanagerapptest3/screens/notifications_screen.dart';
import 'package:moneymanagerapptest3/screens/about_page.dart';
import 'package:moneymanagerapptest3/screens/welcome_screen.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'MyHomePage';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final messageTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;

  String messageText;

  var now = new DateTime.now();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;

        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
//    Color primaryColor = Color.fromRGBO(255, 82, 48, 1);
    Color primaryColor = Colors.teal;
//    final currentUser = loggedInUser.email;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: CircleAvatar(
                          maxRadius: 30.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Test User Name'),
                            Text('Test User Email address'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AboutPage.id);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () => Share.share("Check out The History of Everything! " +
                    ("https://play.google.com/store/apps/details?id=com.twodimensions.timeline")),
              ),
              ListTile(
                leading: Icon(Icons.star_border),
                title: Text('Rate Us'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.bug_report),
                title: Text('Report Bug'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.sms),
                title: Text('Suggestions'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log Out'),
                onTap: () {
                  _auth.signOut();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, WelcomeScreen.id);
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 170.0,
                    decoration: BoxDecoration(color: primaryColor),
                  ),
                  Expanded(
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.teal.withOpacity(0.1)),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(color: primaryColor)),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.menu),
                            color: Colors.white,
                            iconSize: 30.0,
                            onPressed: () {
                              _scaffoldKey.currentState.openDrawer();
                            }),
                        IconButton(
                          icon: Icon(Icons.notifications_none),
                          color: Colors.white,
                          iconSize: 30.0,
                          onPressed: () {
                            Navigator.pushNamed(context, NotificationScreen.id);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                //Total Expenditure Widget
                Expenditure(),

                MainMenu(),

                UsersList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
