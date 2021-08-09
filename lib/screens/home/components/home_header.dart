import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../../constants/size_config.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final provider = watch(cartProvider);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_history),
                  SizedBox(
                    width: 2,
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(200, context),
                    child: Text(
                      "Behined Nehru Garden,New Colony Lalsot",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              )),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: provider.getProducts.length > 0
                ? provider.getProducts.length
                : 0,
            press: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: CartScreen())),
          ),
        ],
      ),
    );
  }
}
