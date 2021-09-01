import 'package:delivery_app/components/loading_widget.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/home/home_screen.dart';
import 'package:delivery_app/screens/location/page.dart';
import 'package:delivery_app/screens/login/login.dart';
import 'package:delivery_app/screens/name/name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CheckUser extends ConsumerWidget {
  const CheckUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
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

class CheckLocation extends ConsumerWidget {
  const CheckLocation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: FutureBuilder<Placemark>(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final postion = snapshot.data;
              return postion.postalCode == "303503"
                  ? HomeScreen()
                  : NoLocation();
            }
          }
          return CustomLoadingWidget();
        },
      ),
    );
  }

  Future<Placemark> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    final position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks[0];
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
