import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:moneymanagerapptest3/mohak/models/full_screen_image.dart';
import 'package:moneymanagerapptest3/mohak/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatScreen extends StatefulWidget {
  String name;
  String photoUrl;
  String receiverUid;
  ChatScreen({this.name, this.photoUrl, this.receiverUid});

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Message _message;

  var _formKey = GlobalKey<FormState>();
  var map = Map<String, dynamic>();
  CollectionReference _collectionReference;
  DocumentReference _receiverDocumentReference;
  DocumentReference _senderDocumentReference;
  DocumentReference _documentReference;
  DocumentSnapshot documentSnapshot;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _senderuid;

  String activeUserUid;
  var listItem;
  String receiverPhotoUrl, senderPhotoUrl, receiverName, senderName;
  StreamSubscription<DocumentSnapshot> subscription;
  File imageFile;
  StorageReference _storageReference;
  TextEditingController _messageController;

  String description;
  String amount;

//  Timestamp messageDateTime = Timestamp().now;

  @override
  void initState() {
    super.initState();

    _messageController = TextEditingController();
    getUID().then((user) {
      setState(() {
        _senderuid = user.uid;
        activeUserUid = user.uid;
        print("sender uid : $_senderuid");
        getSenderPhotoUrl(_senderuid).then((snapshot) {
          setState(() {
            senderPhotoUrl = snapshot['photoUrl'];
            senderName = snapshot['name'];
          });
        });
        getReceiverPhotoUrl(widget.receiverUid).then((snapshot) {
          setState(() {
            receiverPhotoUrl = snapshot['photoUrl'];
            receiverName = snapshot['name'];
          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  void addMessageToDb(Message message) async {
    print("Message : ${message.message}");
    map = message.toMap();

    print("Map : ${map}");

    _collectionReference = Firestore.instance
        .collection("messages")
        .document(message.senderUid)
        .collection(widget.receiverUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    if (_senderuid != widget.receiverUid) {
      _collectionReference = Firestore.instance
          .collection("messages")
          .document(widget.receiverUid)
          .collection(message.senderUid);

      _collectionReference.add(map).whenComplete(() {
        print("Messages added to db");
      });
    }

    _messageController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.withOpacity(0.7),
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTransactionScreen(),
              ),
            ),
          );
        },
      ),
      body: Form(
        key: _formKey,
        child: _senderuid == null
            ? Container(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  //buildListLayout(),

                  ChatMessagesListWidget(),
//                    Divider(
//                      height: 20.0,
//                      color: Colors.black,
//                    ),
//                  Container(
////      height: 55.0,
////      color: Colors.red,
////      margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                    child: Row(
//                      children: <Widget>[
//                        Container(
////            margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                          child: IconButton(
//                            splashColor: Colors.white,
//                            icon: Icon(
//                              Icons.receipt,
//                              color: Colors.black,
//                            ),
//                            onPressed: () {
//                              pickImage();
//                            },
//                          ),
//                        ),
////          Flexible(
////            child: TextFormField(
////              validator: (String input) {
////                if (input.isEmpty) {
////                  return "Please enter message";
////                }
////              },
////              controller: _messageController,
////              decoration: InputDecoration(
////                hintText: "Enter message...",
////                labelText: "Message",
////                border: OutlineInputBorder(
////                  borderRadius: BorderRadius.circular(5.0),
////                ),
////              ),
////              onFieldSubmitted: (value) {
////                _messageController.text = value;
////              },
////            ),
////          ),
////          Container(
//////            margin: const EdgeInsets.symmetric(horizontal: 4.0),
////            child: IconButton(
////              splashColor: Colors.white,
////              icon: Icon(
////                Icons.send,
////                color: Colors.black,
////              ),
////              onPressed: () {
//////                if (_formKey.currentState.validate()) {
//////                  sendMessage();
//////                }
////              },
////            ),
////          ),
////          VerticalDivider(),
////          Container(
////            margin: const EdgeInsets.symmetric(horizontal: 4.0),
////            child: IconButton(
////              splashColor: Colors.white,
////              icon: Icon(
////                Icons.add,
////                color: Colors.black,
////              ),
////              onPressed: () {
////                showModalBottomSheet(
////                  context: context,
////                  isScrollControlled: true,
////                  builder: (context) => SingleChildScrollView(
////                    child: Container(
////                      padding: EdgeInsets.only(
////                          bottom: MediaQuery.of(context).viewInsets.bottom),
////                      child: AddTransactionScreen(),
////                    ),
////                  ),
////                );
////              },
////            ),
////          )
//                      ],
//                    ),
//                  ),
//                    ChatInputWidget(),
//                    SizedBox(
//                      height: 10.0,
//                    ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.tealAccent.withOpacity(0.5),
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
//              height: 50.0,
//            margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    splashColor: Colors.white,
                    icon: Icon(
                      Icons.receipt,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      pickImage();
                    },
                  ),
//                  VerticalDivider(),
                  Text('Add Receipt'),
                ],
              ),
            ),
//            GestureDetector(
//              onTap: () {
//                final snackBar = SnackBar(content: Text("Tap"));
//
//                Scaffold.of(context).showSnackBar(snackBar);
//              },
//              child: Container(
//                margin: const EdgeInsets.only(right: 20.0),
//                child: Text(
//                  '₹ ' + '0.00',
//                  style: TextStyle(
//                      color: Colors.black,
//                      fontSize: 25.0,
//                      fontWeight: FontWeight.bold),
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }

  Widget ChatInputWidget() {
//    return Container(
////      height: 55.0,
////      color: Colors.red,
////      margin: const EdgeInsets.symmetric(horizontal: 8.0),
//      child: Row(
//        children: <Widget>[
//          Container(
////            margin: const EdgeInsets.symmetric(horizontal: 4.0),
//            child: IconButton(
//              splashColor: Colors.white,
//              icon: Icon(
//                Icons.receipt,
//                color: Colors.black,
//              ),
//              onPressed: () {
//                pickImage();
//              },
//            ),
//          ),
////          Flexible(
////            child: TextFormField(
////              validator: (String input) {
////                if (input.isEmpty) {
////                  return "Please enter message";
////                }
////              },
////              controller: _messageController,
////              decoration: InputDecoration(
////                hintText: "Enter message...",
////                labelText: "Message",
////                border: OutlineInputBorder(
////                  borderRadius: BorderRadius.circular(5.0),
////                ),
////              ),
////              onFieldSubmitted: (value) {
////                _messageController.text = value;
////              },
////            ),
////          ),
////          Container(
//////            margin: const EdgeInsets.symmetric(horizontal: 4.0),
////            child: IconButton(
////              splashColor: Colors.white,
////              icon: Icon(
////                Icons.send,
////                color: Colors.black,
////              ),
////              onPressed: () {
//////                if (_formKey.currentState.validate()) {
//////                  sendMessage();
//////                }
////              },
////            ),
////          ),
////          VerticalDivider(),
////          Container(
////            margin: const EdgeInsets.symmetric(horizontal: 4.0),
////            child: IconButton(
////              splashColor: Colors.white,
////              icon: Icon(
////                Icons.add,
////                color: Colors.black,
////              ),
////              onPressed: () {
////                showModalBottomSheet(
////                  context: context,
////                  isScrollControlled: true,
////                  builder: (context) => SingleChildScrollView(
////                    child: Container(
////                      padding: EdgeInsets.only(
////                          bottom: MediaQuery.of(context).viewInsets.bottom),
////                      child: AddTransactionScreen(),
////                    ),
////                  ),
////                );
////              },
////            ),
////          )
//        ],
//      ),
//    );
  }

  Future<String> pickImage() async {
    var selectedImage =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = selectedImage;
    });
    _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    StorageUploadTask storageUploadTask = _storageReference.putFile(imageFile);
    var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();

    print("URL: $url");
    uploadImageToDb(url);
    return url;
  }

  void uploadImageToDb(String downloadUrl) {
    _message = Message.withoutMessage(
        receiverUid: widget.receiverUid,
        senderUid: _senderuid,
        photoUrl: downloadUrl,
        timestamp: FieldValue.serverTimestamp(),
        type: 'image');
    var map = Map<String, dynamic>();
    map['senderUid'] = _message.senderUid;
    map['receiverUid'] = _message.receiverUid;
    map['type'] = _message.type;
    map['timestamp'] = _message.timestamp;
    map['photoUrl'] = _message.photoUrl;

    print("Map : ${map}");
    _collectionReference = Firestore.instance
        .collection("messages")
        .document(_message.senderUid)
        .collection(widget.receiverUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    _collectionReference = Firestore.instance
        .collection("messages")
        .document(widget.receiverUid)
        .collection(_message.senderUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });
  }

  void sendMessage(String amount) async {
    print("Inside send message");
    var text = _messageController.text;
    print(text);
    _message = Message(
        receiverUid: widget.receiverUid,
        senderUid: _senderuid,
        amount: amount,
        message: text,
        timestamp: FieldValue.serverTimestamp(),
        type: 'text');
    print(
        "receiverUid: ${widget.receiverUid} , senderUid : ${_senderuid} , message: ${text}");
    print(
        "timestamp: ${DateTime.now().millisecond}, type: ${text != null ? 'text' : 'image'}");
    addMessageToDb(_message);
  }

//  void sendTransaction() async {
//    print("Inside send message");
//    var text = _messageController.text;
////    print(text);
//    _message = Message(
//        receiverUid: widget.receiverUid,
//        senderUid: _senderuid,
//        amount: amount,
//        description: text,
//        timestamp: FieldValue.serverTimestamp(),
//        type: 'text');
////    print(
////        "receiverUid: ${widget.receiverUid} , senderUid : ${_senderuid} , message: ${text}");
////    print(
////        "timestamp: ${DateTime.now().millisecond}, type: ${text != null ? 'text' : 'image'}");
//    addMessageToDb(_message);
//  }

  Future<FirebaseUser> getUID() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<DocumentSnapshot> getSenderPhotoUrl(String uid) {
    var senderDocumentSnapshot =
        Firestore.instance.collection('users').document(uid).get();
    return senderDocumentSnapshot;
  }

  Future<DocumentSnapshot> getReceiverPhotoUrl(String uid) {
    var receiverDocumentSnapshot =
        Firestore.instance.collection('users').document(uid).get();
    return receiverDocumentSnapshot;
  }

  Widget ChatMessagesListWidget() {
    print("SENDERUID : $_senderuid");
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('messages')
            .document(_senderuid)
            .collection(widget.receiverUid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No messages FOUND!!'),
            );
          } else {
            listItem = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  chatMessageItem(snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }

  Widget chatMessageItem(DocumentSnapshot documentSnapshot) {
    return buildChatLayout(documentSnapshot);
  }

  Widget buildChatLayout(DocumentSnapshot snapshot) {
//    var dateOnly = '0000-00-00';
//    var timeStamp = snapshot['timestamp'];
//    var messageDateTime = DateTime.parse(timeStamp.toDate().toString());
//    dateOnly = messageDateTime.toString().substring(0, 10);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        snapshot['type'] == 'text'
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        snapshot['senderUid'] == _senderuid
                            ? Container(
//                                padding: EdgeInsets.zero,
                                width: 5.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              )
                            : Container(
                                width: 5.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.yellowAccent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/noimage.jpeg'),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  '₹' + snapshot['amount'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Date: '
//                                      + '$dateOnly',
                                  ,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    'Desc: ' + snapshot['message'],
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Row(
//                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Receipt:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
//                  Icon(Icons.arrow_forward),
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreenImage(
                                    photoUrl: snapshot['photoUrl'],
                                  )));
                    }),
                    child: Hero(
                      tag: snapshot['photoUrl'],
                      child: FadeInImage(
                        image: NetworkImage(snapshot['photoUrl']),
                        placeholder: AssetImage('assets/blankimage.png'),
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                  )
                ],
              )
//        Padding(
//          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
//          child: Row(
//            mainAxisAlignment: snapshot['senderUid'] == _senderuid
//                ? MainAxisAlignment.end
//                : MainAxisAlignment.start,
//            children: <Widget>[
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.end,
//                children: <Widget>[
//                  snapshot['senderUid'] == _senderuid
//                      ? Text(
//                          senderName == null ? "" : senderName,
//                          style: TextStyle(
//                            color: Colors.grey,
//                            fontSize: 10.0,
//                          ),
//                        )
//                      : Text(
//                          receiverName == null ? "" : receiverName,
//                          style: TextStyle(
//                            color: Colors.grey,
//                            fontSize: 10.0,
//                          ),
//                        ),
//                  snapshot['type'] == 'text'
//                      ? Row(
//                          children: <Widget>[
//                            Text(
//                              snapshot['amount'],
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontSize: 16.0,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            Text(
//                              snapshot['message'],
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontSize: 16.0,
//                                  fontWeight: FontWeight.bold),
//                            )
//                          ],
//                        )
//                      : InkWell(
//                          onTap: (() {
//                            Navigator.push(
//                                context,
//                                new MaterialPageRoute(
//                                    builder: (context) => FullScreenImage(
//                                          photoUrl: snapshot['photoUrl'],
//                                        )));
//                          }),
//                          child: Hero(
//                            tag: snapshot['photoUrl'],
//                            child: FadeInImage(
//                              image: NetworkImage(snapshot['photoUrl']),
//                              placeholder: AssetImage('assets/blankimage.png'),
//                              width: 200.0,
//                              height: 200.0,
//                            ),
//                          ),
//                        )
//                ],
//              )
//            ],
//          ),
//        ),
      ],
    );
  }

  Widget AddTransactionScreen() {
//    String description;
//    int amount;
//  @override
//  Widget build(BuildContext context) {
//    String newTaskTitle;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Text(
                    'Add New Transaction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.teal,
                    ),
                  ),
                ),
                IconButton(
                    iconSize: 15.0,
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            TextFormField(
              validator: (String input) {
                if (input.isEmpty) {
                  return "Please enter message";
                }
              },

              autofocus: true,
//              controller: _messageController,

              decoration: InputDecoration(hintText: 'Amount'),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
//              inputFormatters: <TextInputFormatter>[
//                WhitelistingTextInputFormatter.digitsOnly
//              ],
              onChanged: (value) {
                amount = value;
              },
            ),
            TextFormField(
              validator: (String input) {
                if (input.isEmpty) {
                  return "Please enter message";
                }
              },
              autofocus: true,
              controller: _messageController,
              decoration: InputDecoration(hintText: 'Description'),
              textAlign: TextAlign.center,
              onFieldSubmitted: (value) {
                description = value;
                _messageController.text = value;
              },
            ),
            FlatButton(
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.teal,
//              if(amount != null && description !=null)
//              {
                onPressed: () {
                  if (amount != null && _formKey.currentState.validate()) {
                    sendMessage(amount);
                  }
                  amount = null;
                  Navigator.pop(context);
                }
//              }
                ),
          ],
        ),
      ),
    );
  }
}

//}
