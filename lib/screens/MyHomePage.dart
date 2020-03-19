import 'package:flutter/material.dart';
//import 'package:moneymanagerapptest3/screens/chat_screen.dart';
import "package:share/share.dart";
import 'package:moneymanagerapptest3/assets/Expenditure.dart';
import 'package:moneymanagerapptest3/assets/MainMenu.dart';
import 'package:moneymanagerapptest3/assets/UsersList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneymanagerapptest3/screens/NotificationScreen.dart';
import 'package:moneymanagerapptest3/screens/about_page.dart';
//import 'package:moneymanagerapptest3/screens/registration_screen.dart';
import 'package:moneymanagerapptest3/screens/welcome_screen.dart';
import 'package:moneymanagerapptest3/constants.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class MyHomePage extends StatefulWidget {
  static const String id = 'MyHomePage';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final messageTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String messageText;

//  String loggedInUserEmail = loggedInUser.email;

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
//                    CircleAvatar(
//
//                    ),

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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
//                  Navigator.pop(context);
                  Navigator.pushNamed(context, AboutPage.id);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () => Share.share("Check out The History of Everything! " +
                    ("https://play.google.com/store/apps/details?id=com.twodimensions.timeline")),

//                onTap: () {
//                  // Update the state of the app
//                  // ...
//                  // Then close the drawer
//                  Navigator.pop(context);
//                },
              ),
              ListTile(
                leading: Icon(Icons.star_border),
                title: Text('Rate Us'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.bug_report),
                title: Text('Report Bug'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.sms),
                title: Text('Suggestions'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
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
//              height: 170.0,
//              decoration: BoxDecoration(color: primaryColor),
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
                //Bottom Text Field
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    Container(
//                      decoration: kMessageContainerDecoration,
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Expanded(
//                            child: TextField(
////                              controller: messageTextController,
//                              onChanged: (value) {
//                                messageText = value;
//                              },
//                              decoration: kMessageTextFieldDecoration,
//                            ),
//                          ),
//                          FlatButton(
//                            onPressed: () {
////                              messageTextController.clear();
//                              _firestore.collection('messages').add(
//                                {
//                                  'text': messageText,
//                                  'sender': loggedInUser.email,
////                                  'time': now,
//                                },
//                              );
//                            },
//                            child: Text(
//                              'Send',
//                              style: kSendButtonTextStyle,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data.documents;

        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final messageText = message.data['text'];

          final messageSender = message.data['sender'];

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
          );
          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text});

  final String sender;

  final String text;

//  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0.0, 3.0),
                blurRadius: 15.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
              ),
              Text(sender),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text('Date: 04-03-2020'),
              Container(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
