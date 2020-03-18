import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagerapptest3/screens/MyHomePage.dart';
import 'package:moneymanagerapptest3/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: CircleAvatar(
              backgroundColor: Colors.lightBlueAccent,
              radius: 50.0,
              child: Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              RoundedButton(
                  title: 'Continue with Google',
                  colour: Colors.white,
                  backgroundImage: Image.network(
                      'https://pngimg.com/uploads/google/google_PNG19635.png'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/MyHomePage');
                  }),
              RoundedButton(
                  title: 'Continue with Facebook',
                  colour: Colors.white,
                  backgroundImage: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png'),
//              icon: Icon(
//                Icons.face,
//                color: Colors.green,
//              ),
                  onPressed: () {}),
              RoundedButton(
                title: 'Continue with Email',
                colour: Colors.white,
                backgroundImage: Image.network(
                    'https://lh3.googleusercontent.com/YTB4ZfOQpnJUB4F1G7GCoc8J0Y3xfEyLEs07vUotIz6WDkQ1jGIhqmAfnYHICg3NAyI'),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'By Continuing, you agree to our Terms of Service and Privacy Policy',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.backgroundImage,
      this.colour,
      this.title,
      @required this.onPressed});
  final Image backgroundImage;
  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 100.0,
          height: 42.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.white,
                  child: backgroundImage,
                ),
                SizedBox(width: 20.0),
                Text(
                  title,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
