import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moneymanagerapptest3/screens/search_users_screen.dart';
import 'package:moneymanagerapptest3/screens/my_home_page.dart';
import 'package:moneymanagerapptest3/screens/notifications_screen.dart';
import 'package:moneymanagerapptest3/screens/splash_screen.dart';
import 'package:moneymanagerapptest3/screens/about_page.dart';
import 'package:moneymanagerapptest3/screens/login_screen.dart';
import 'package:moneymanagerapptest3/screens/registration_screen.dart';
import 'package:moneymanagerapptest3/screens/welcome_screen.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      initialRoute: SplashScreen.id,
//      routes: {
//        SplashScreen.id: (context) => SplashScreen(),
//        WelcomeScreen.id: (context) => WelcomeScreen(),
//        LoginScreen.id: (context) => LoginScreen(),
//        RegistrationScreen.id: (context) => RegistrationScreen(),
//        MyHomePage.id: (context) => MyHomePage(),
//        NotificationScreen.id: (context) => NotificationScreen(),
//        AboutPage.id: (context) => AboutPage(),
//      },
//    );
//  }
//}

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoggedIn = false;

  void isSignedIn() async {
    if (await googleSignIn.isSignedIn()) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Money App",
      theme: ThemeData(primarySwatch: Colors.red),
//      initialRoute: SplashScreen.id,
      routes: {
//        SplashScreen.id: (context) => SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MyHomePage.id: (context) => MyHomePage(),
        NotificationScreen.id: (context) => NotificationScreen(),
        AboutPage.id: (context) => AboutPage(),
        //Search User Screen
        SeachAppBarRecipe.id: (context) => SeachAppBarRecipe(),
      },
      home: isLoggedIn == true ? MyHomePage() : WelcomeScreen(),
    );
  }
}

//import 'package:flutter/material.dart';
//
//void main() => runApp(new MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Flutter Demo',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: new MyHomePage(title: 'ListView with Search'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  TextEditingController editingController = TextEditingController();
//
//  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
//  var items = List<String>();
//
//  @override
//  void initState() {
//    items.addAll(duplicateItems);
//    super.initState();
//  }
//
//  void filterSearchResults(String query) {
//    List<String> dummySearchList = List<String>();
//    dummySearchList.addAll(duplicateItems);
//    if (query.isNotEmpty) {
//      List<String> dummyListData = List<String>();
//      dummySearchList.forEach((item) {
//        if (item.contains(query)) {
//          dummyListData.add(item);
//        }
//      });
//      setState(() {
//        items.clear();
//        items.addAll(dummyListData);
//      });
//      return;
//    } else {
//      setState(() {
//        items.clear();
//        items.addAll(duplicateItems);
//      });
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(widget.title),
//      ),
//      body: Container(
//        child: Column(
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: TextField(
//                onChanged: (value) {
//                  filterSearchResults(value);
//                },
//                controller: editingController,
//                decoration: InputDecoration(
//                    labelText: "Search",
//                    hintText: "Search",
//                    prefixIcon: Icon(Icons.search),
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//              ),
//            ),
//            Expanded(
//              child: ListView.builder(
//                shrinkWrap: true,
//                itemCount: items.length,
//                itemBuilder: (context, index) {
//                  return ListTile(
//                    title: Text('${items[index]}'),
//                  );
//                },
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
