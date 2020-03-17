import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  static const String id = 'UserScreen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(),
            Expanded(
              child: Container(
                color: Colors.red,
                width: 100.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
