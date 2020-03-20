import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFriend extends StatefulWidget {
  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  final _firestore = Firestore.instance;

  FirebaseUser loggedInUser;

  String messageText;

  String sender;

  @override
  Widget build(BuildContext context) {
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
              textAlign: TextAlign.center,
              onChanged: (value) {
                sender = value;
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
                _firestore.collection('messages').add(
                  {
                    'text': messageText,
                    'sender': sender,
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

//
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
