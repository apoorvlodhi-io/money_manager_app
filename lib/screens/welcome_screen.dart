import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:moneymanagerapptest3/screens/registration_screen.dart';
import 'package:moneymanagerapptest3/components/welcome_screen_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _launchUrl(String url) {
    canLaunch(url).then((bool success) {
      if (success) {
        launch(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.green,
                    size: 50.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Money Manager App',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              WelcomeScreenButton(
                  title: 'Continue with Google',
                  colour: Colors.white,
                  backgroundImage: Image.network(
                      'https://pngimg.com/uploads/google/google_PNG19635.png'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/MyHomePage');
                  }),
              WelcomeScreenButton(
                  title: 'Continue with Facebook',
                  colour: Colors.white,
                  backgroundImage: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png'),
//              icon: Icon(
//                Icons.face,
//                color: Colors.green,
//              ),
                  onPressed: () {}),
              WelcomeScreenButton(
                title: 'Continue with Email',
                colour: Colors.white,
//                backgroundImage: Image.asset('images/email_logo.png'),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
//                            color:
//                                darkText.withOpacity(darkText.opacity * 0.75),
                            color: Colors.black,
//                            fontFamily: "Roboto",
                            fontSize: 10.0,
                            height: 1.5),
                        children: [
                          TextSpan(
                            text: 'By Continuing, you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchUrl(
                                  "https://github.com/apoorvlodhi-io/money_manager_app/blob/master/README.md"),
                          ),
                          TextSpan(
                            text: ' and ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchUrl(
                                  "https://github.com/apoorvlodhi-io/money_manager_app/blob/master/README.md"),
                          ),
                        ],
                      ),
                    ),
//                    Text(
//                      'By Continuing, you agree to our Terms of Service and Privacy Policy',
//                      style: TextStyle(
//                        color: Colors.grey,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 10.0,
//                      ),
//                    ),
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
