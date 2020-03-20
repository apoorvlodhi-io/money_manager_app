import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiveMoneySheet extends StatefulWidget {
  @override
  _ReceiveMoneySheetState createState() => _ReceiveMoneySheetState();
}

class _ReceiveMoneySheetState extends State<ReceiveMoneySheet> {
  final _auth = FirebaseAuth.instance;

  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;

  String messageText;
  String friendName;

  var now = new DateTime.now();

//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    String messageText;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                messageText = value;
              },
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'friendname',
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                friendName = value;
              },
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
//                              messageTextController.clear();
                _firestore.collection('messages').add(
                  {
                    'text': messageText,
                    'sender': friendName,
//                                  'time': now,
                  },
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
