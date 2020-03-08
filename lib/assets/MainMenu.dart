import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 15.0)
            ]),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.purple.withOpacity(0.1),
                        child: IconButton(
                          padding: EdgeInsets.all(15.0),
                          icon: Icon(Icons.send),
                          color: Colors.purple,
                          iconSize: 30.0,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Send',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.blue.withOpacity(0.1),
                        child: IconButton(
                          padding: EdgeInsets.all(15.0),
                          icon: Icon(Icons.credit_card),
                          color: Colors.blue,
                          iconSize: 30.0,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Pay',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.orange.withOpacity(0.1),
                        child: IconButton(
                          padding: EdgeInsets.all(15.0),
                          icon: Icon(Icons.receipt),
                          color: Colors.orange,
                          iconSize: 30.0,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Request',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
