import 'package:delivery_app/components/coustom_bottom_nav_bar.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/screens/history/history.dart';
import 'package:delivery_app/screens/profile/profile_screen.dart';
import 'package:delivery_app/screens/search/search.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/body.dart';

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
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data);
      print(event.notification.title);
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
