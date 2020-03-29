import 'package:flutter/material.dart';
import 'package:moneymanagerapptest3/screens/add_friend.dart';
import 'package:moneymanagerapptest3/screens/search_users_screen.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 15.0)
            ]),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.green.withOpacity(0.1),
                        child: IconButton(
                          padding: EdgeInsets.all(15.0),
                          icon: Icon(Icons.call_received),
                          color: Colors.green,
                          iconSize: 30.0,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Receive',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.red.withOpacity(0.1),
                        child: IconButton(
                          padding: EdgeInsets.all(15.0),
                          icon: Icon(Icons.call_made),
                          color: Colors.red,
                          iconSize: 30.0,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Owe',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.orange.withOpacity(0.1),
                        child: IconButton(
                          padding: EdgeInsets.all(15.0),
                          icon: Icon(Icons.add),
                          color: Colors.orange,
                          iconSize: 30.0,
                          onPressed: () {
                            Navigator.pushNamed(context, SeachAppBarRecipe.id);
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Add Friend',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
