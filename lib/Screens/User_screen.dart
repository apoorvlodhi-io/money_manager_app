import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
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
