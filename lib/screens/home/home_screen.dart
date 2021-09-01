import 'package:delivery_app/components/coustom_bottom_nav_bar.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/screens/history/history.dart';
import 'package:delivery_app/screens/profile/profile_screen.dart';
import 'package:delivery_app/screens/search/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/body.dart';

Future showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(
      0,
      'GeeksforGeeks',
      'Your are one step away to connect with GeeksforGeeks',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  static Page page() => MaterialPage<void>(child: HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

int currentIndex = 0;
PageController pageController = PageController();

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    FirebaseMessaging.onBackgroundMessage(messageHandler);
    FirebaseMessaging.onMessage.listen((event) async {
      print(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser.phoneNumber);
    return Consumer(
      builder: (context, watch, child) {
        return Scaffold(
          body: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                Body(),
                SearchPage(),
                HistoryScreen(),
                ProfileScreen(),
              ],
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              }),
          bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
        );
      },
    );
  }
}
