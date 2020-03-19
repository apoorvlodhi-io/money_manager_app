import 'package:flutter/material.dart';
import 'package:moneymanagerapptest3/cards/FriendCard.dart';
import 'package:moneymanagerapptest3/screens/MyHomePage.dart';

class UsersList extends StatefulWidget {
  const UsersList({
    Key key,
  }) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
//                    margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 1.0),
//                    padding: EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 15.0)
            ]),
        child: Column(
          children: <Widget>[
            MessagesStream(),
//            FriendCard(),
//            FriendCard(),
//            FriendCard(),
//            FriendCard(),
//            FriendCard(),
//            FriendCard(),
//            FriendCard(),
          ],
        ),
      ),
    );
  }
}
