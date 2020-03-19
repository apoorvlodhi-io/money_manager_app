import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moneymanagerapptest3/screens/MyHomePage.dart';
import 'package:moneymanagerapptest3/screens/NotificationScreen.dart';
import 'package:moneymanagerapptest3/screens/SplashScreen.dart';
import 'package:moneymanagerapptest3/screens/about_page.dart';
import 'package:moneymanagerapptest3/screens/login_screen.dart';
import 'package:moneymanagerapptest3/screens/registration_screen.dart';
import 'package:moneymanagerapptest3/screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MyHomePage.id: (context) => MyHomePage(),
        NotificationScreen.id: (context) => NotificationScreen(),
        AboutPage.id: (context) => AboutPage(),
      },
    );
  }
}
