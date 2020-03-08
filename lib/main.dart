import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Screens/MyHomePage.dart';
import 'package:moneymanagerapptest3/Screens/User_screen.dart';
import 'package:moneymanagerapptest3/Screens/NotificationScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Management',
      theme: ThemeData(primarySwatch: Colors.grey),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/NotificationScreen': (context) => NotificationScreen(),
        '/user_screen': (context) => UserScreen(),
      },
    );
  }
}
