import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/screens/auth/auth_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage("assets/images/background.png"),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(20, context)),
          child: DefaultButton(
            text: "Get Started",
            press: () async {
              final ls = ProviderContainer().read(localStorageProvider);
              ls.saveBool(key: Constants.firstTime, value: false);
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: RouteBasedOnAuth()));
            },
          ),
        ),
      ],
    ));
  }
}
