import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../../constants/size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

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
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Search Icon.svg",
            // numOfitem: 3,
            press: () {},
          ),
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
