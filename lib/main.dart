import 'package:delivery_app/auth/bloc/authentication_bloc.dart';
import 'package:delivery_app/helper/userrepositry.dart';
import 'package:delivery_app/screens/home/home_screen.dart';
import 'package:delivery_app/screens/sign_in/bloc/login_bloc.dart';
import 'package:delivery_app/screens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/routes.dart';
import 'screens/splash/splash_screen.dart';
import 'constants/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPrefrences:sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPrefrences;

  MyApp({Key key, @required this.sharedPrefrences}):super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

Future<void> messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences = widget.sharedPrefrences;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: StreamBuilder<User>(
        builder: (context,),
      ),
      routes: routes,
    );
  }
}
