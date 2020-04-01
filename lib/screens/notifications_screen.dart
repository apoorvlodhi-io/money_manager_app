import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const String id = 'notifications_screen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Notifications'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Here you will receive Friend Requests'),
              Text('and transaction notifications.'),
              Text('Features to be added sonn :)'),
              RaisedButton(
                color: Colors.lightBlue,
                child: Text('Go Back To Previous Screen'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
