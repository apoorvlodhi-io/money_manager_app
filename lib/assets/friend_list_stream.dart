import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneymanagerapptest3/cards/friend_card.dart';

class FriendListStream extends StatelessWidget {
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;

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

        final messages = snapshot.data.documents.reversed;

        List<FriendCard> friendCards = [];

        for (var message in messages) {
          final messageText = message.data['text'];

          final messageSender = message.data['sender'];

          final friendCard = FriendCard(
            sender: messageSender,
            text: messageText,
          );
          friendCards.add(friendCard);
        }

        if (friendCards.length == 0) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'NO FRIENDS TO DISPLAY',
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  '😞',
                  style: TextStyle(fontSize: 25.0),
                ),
              ],
            ),
          );
        }

        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: friendCards,
          ),
        );
      },
    );
  }
}
