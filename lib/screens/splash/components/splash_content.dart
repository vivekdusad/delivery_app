import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:flutter/material.dart';



class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "TOKOTO",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36,context),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265,context),
          width: getProportionateScreenWidth(235,context),
        ),
      ],
    );
  }
}
