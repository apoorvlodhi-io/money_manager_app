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
          child: RaisedButton(
            color: Colors.red,
            child: Text('Go Back To Screen 1'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
