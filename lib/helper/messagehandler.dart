import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessageHandler extends StatefulWidget {
  const MessageHandler({Key key}) : super(key: key);

  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((event) {});
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
