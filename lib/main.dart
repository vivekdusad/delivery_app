import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/helper/sharedprefrences.dart';
import 'package:delivery_app/screens/home/home_screen.dart';
import 'package:delivery_app/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants/routes.dart';
import 'constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: false,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(ProviderScope(child: MyApp()));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  MyApp();
  @override
  _MyAppState createState() => _MyAppState();
}

Future<void> messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: Consumer(
        builder: (context, watch, child) {
          return FutureBuilder<LocalStorage>(
            future: watch(localStorageProvider),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.contains(key: Constants.firstTime)) {
                  return HomeScreen();
                }
                return SplashScreen();
              }
              return Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
      routes: routes,
      builder: EasyLoading.init(),
    );
  }
}
