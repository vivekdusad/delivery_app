
import 'package:delivery_app/screens/history/history.dart';
import 'package:delivery_app/screens/results/results.dart';
import 'package:delivery_app/screens/search/search.dart';
import 'package:flutter/widgets.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/complete_profile/complete_profile_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/otp/otp_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),  
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  Otpscreen.routeName: (context) => Otpscreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SearchPage.routeName: (context) => SearchPage(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  HistoryScreen.routeName: (context) => HistoryScreen(),
  ResultsPage.routeName: (context) => ResultsPage(),
  
};
