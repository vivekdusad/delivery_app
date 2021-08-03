import 'package:flutter/material.dart';
import 'package:delivery_app/screens/splash/components/body.dart';
import 'package:delivery_app/constants/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    
    return Scaffold(
      body: Body(),
    );
  }
}
