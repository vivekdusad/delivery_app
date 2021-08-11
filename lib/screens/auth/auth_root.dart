import 'package:delivery_app/components/loading_widget.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/home/home_screen.dart';
import 'package:delivery_app/screens/login/login.dart';
import 'package:delivery_app/screens/name/name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckUser extends ConsumerWidget {
  const CheckUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context,ScopedReader watch) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: watch(phoneauth).checkUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              bool isFirstTime = snapshot.data;
              return isFirstTime ? HomeScreen() : NamesPage();
            }
          }
          return CustomLoadingWidget();
        },
      ),
    );
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
            if (snapshot.data != null && _firebase.currentUser != null)
              return CheckUser();
            else
              return SignInScreen();
          }

          return CustomLoadingWidget();
        });
  }
}
