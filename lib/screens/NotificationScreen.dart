import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const String id = 'notifications_screen';
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
            color: Colors.blue,
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
