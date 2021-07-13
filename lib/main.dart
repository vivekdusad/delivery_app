import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:delivery_app/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/routes.dart';
import 'constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(child: MyApp(sharedPrefrences: sharedPreferences)));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPrefrences;

  MyApp({Key key, @required this.sharedPrefrences}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

Future<void> messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences = widget.sharedPrefrences;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: HomeScreen(),
      routes: routes,
    );
  }
}
