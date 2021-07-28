import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/home/home_screen.dart';
import 'package:delivery_app/screens/login/login.dart';
import 'package:delivery_app/screens/otp/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRoot extends ConsumerWidget {
  const AuthRoot({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final otpsend = watch(otpsentprovider);
    if (otpsend.isOtpSent) {
      return Otpscreen();
    } else {
      return SignInScreen();
    }
  }
}

class RouteBasedOnAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firebase = FirebaseAuth.instance;
    return StreamBuilder(
        stream: _firebase.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null&&_firebase.currentUser != null)
              return HomeScreen();
            else
              return AuthRoot();
          }

          return CircularProgressIndicator();
        });
  }
}
