import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor
  }) : super(key: key);
  final String text;
  final Function press;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56, context),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: color ?? kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18, context),
            color: textColor??Colors.white,
          ),
        ),
      ),
    );
  }
}
