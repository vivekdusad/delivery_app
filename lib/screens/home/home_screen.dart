import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/components/coustom_bottom_nav_bar.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  static Page page() => MaterialPage<void>(child: HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
Future _showNotificationWithDefaultSound(flip) async {
    
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    
  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
  );
  await flip.show(0, 'Order',
    'New Order',
    platformChannelSpecifics, payload: 'Default_Sound'
  );
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  
  @override
  void initState() {
    FirebaseMessaging.onBackgroundMessage(messageHandler);

    FirebaseMessaging.onMessage.listen((event) {
      print(event.data);
      FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
      
    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();
      
    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip);
    });
    // messaging.subscribeToTopic("order");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
