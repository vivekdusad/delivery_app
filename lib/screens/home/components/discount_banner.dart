import 'package:flutter/material.dart';

import '../../../constants/size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20,context)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20,context),
        vertical: getProportionateScreenWidth(15,context),
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: "20% Discount\n",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24,context),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: "From MRP"),
          ],
        ),
      ),
    );
  }
}