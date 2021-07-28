import 'package:delivery_app/screens/favorite/favorite.dart';
import 'package:delivery_app/screens/history/history.dart';
import 'package:delivery_app/screens/results/results.dart';
import 'package:flutter/widgets.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/complete_profile/complete_profile_screen.dart';
import '../screens/forgot_password/forgot_password_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login_success/login_success_screen.dart';
import '../screens/otp/otp_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash/splash_screen.dart';


final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),  
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),  
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  Otpscreen.routeName: (context) => Otpscreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  HistoryScreen.routeName: (context) => HistoryScreen(),
  ResultsPage.routeName: (context) => ResultsPage(),
  FavoriteScreen.routeName: (context) => FavoriteScreen(),
};
