import 'package:delivery_app/components/coustom_bottom_nav_bar.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/main.dart';
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



class _HomeScreenState extends State<HomeScreen> {
  
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    FirebaseMessaging.onBackgroundMessage(messageHandler);
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data);
      print(event.notification.title);
         
    });
    messaging.subscribeToTopic("order");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {        
        return Scaffold(  
          body: Body(),
          bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
        );
      },
    );
  }
}
