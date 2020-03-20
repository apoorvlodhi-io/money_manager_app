import 'package:flutter/material.dart';

class WelcomeScreenButton extends StatelessWidget {
  WelcomeScreenButton(
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
