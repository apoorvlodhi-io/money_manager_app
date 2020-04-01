import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:share/share.dart";
import 'package:moneymanagerapptest3/components/user_details.dart';
import 'package:moneymanagerapptest3/components/user_list.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneymanagerapptest3/components/expenditure_tab.dart';
import 'package:moneymanagerapptest3/components/main_menu.dart';
import 'package:moneymanagerapptest3/components/user_list.dart';
import 'package:moneymanagerapptest3/screens/notifications_screen.dart';
import 'package:moneymanagerapptest3/screens/about_page.dart';
import 'package:moneymanagerapptest3/assets/friend_list_stream.dart';
import 'package:moneymanagerapptest3/screens/chat_screen.dart';

import 'dart:async';
import 'dart:io';

//import 'package:chat_app/chat_screen.dart';
//import 'package:chat_app/home_page.dart';
import '../main.dart';
//import 'package:chat_app/models/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  String activeUserUid;
  String activeUserPhotoUrl;
  String activeUserName;
  String activeUserEmail;
  String emptyString = " ";
  var now = new DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> usersList = [];

  final CollectionReference _collectionReference =
      Firestore.instance.collection("users");

  @override
  void initState() {
    super.initState();
    getUID().then((user) {
      setState(() {
        activeUserUid = user.uid;
        print("activeUser uid : $activeUserUid");
        getactiveUserPhotoUrl(activeUserUid).then((snapshot) {
          setState(() {
            activeUserPhotoUrl = snapshot['photoUrl'];
            activeUserName = snapshot['name'];
            activeUserEmail = snapshot['emailId'];
          });
        });
      });
    });
    _subscription = _collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        usersList = datasnapshot.documents;
        print("Users List ${usersList.length}");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
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
                    Container(
                      child: CircleAvatar(
                        backgroundImage: activeUserPhotoUrl != null
                            ? NetworkImage(activeUserPhotoUrl)
                            : AssetImage('assets/noimage.jpeg'),
                        radius: 30.0,
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          activeUserName != null
                              ? Text(activeUserName.toUpperCase())
                              : Text(emptyString),
                          activeUserEmail != null
                              ? Text(activeUserEmail)
                              : Text(emptyString),
                        ],
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
                onTap: () => Share.share("Check out The Money Manager app! " +
                    ("https://github.com/apoorvlodhi-io/money_manager_app")),
              ),
              ListTile(
                leading: Icon(Icons.star_border),
                title: Text('Rate Us'),
                onTap: () {
//                  final snackBar = SnackBar(content: Text("Tap"));
//
//                  Scaffold.of(context).showSnackBar(snackBar);
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
                onTap: () async {
                  await _firebaseAuth.signOut();
                  await googleSignIn.disconnect();
                  await googleSignIn.signOut();
                  print("Signed Out");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MyApp()),
                      (Route<dynamic> route) => false);
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
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: ,
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
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: usersList.length,
                      itemBuilder: ((context, index) {
                        return Column(
                          children: <Widget>[
                            Divider(),
//                            if(usersList[index].data['uid'] != activeUserUid){}
                            ListTile(
                              leading: CircleAvatar(
//                                backgroundImage: NetworkImage(
//                                    usersList[index].data['photoUrl']),

                                backgroundImage: activeUserPhotoUrl != null
                                    ? NetworkImage(
                                        usersList[index].data['photoUrl'])
                                    : AssetImage('assets/blankimage.png'),
                              ),
                              trailing: Text(
                                '₹' + '0.00',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              title: Text(
                                usersList[index].data['name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                usersList[index].data['emailId'],
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: (() {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                        name: usersList[index].data['name'],
                                        photoUrl:
                                            usersList[index].data['photoUrl'],
                                        receiverUid:
                                            usersList[index].data['uid']),
                                  ),
                                );
                              }),
                              onLongPress: (() {
                                Navigator.pushNamed(context, AboutPage.id);
                              }),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> getUID() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<DocumentSnapshot> getactiveUserPhotoUrl(String uid) {
    var activeUserDocumentSnapshot =
        Firestore.instance.collection('users').document(uid).get();
    return activeUserDocumentSnapshot;
  }
}
