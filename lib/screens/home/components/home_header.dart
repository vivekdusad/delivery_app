import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/user.dart';
import 'package:delivery_app/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
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
      child: WatchBoxBuilder(
          box: Hive.box('user'),
          builder: (context, box) {
            final user = box.get('user') as Users;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          child: SvgPicture.network(
                              "https://avatars.dicebear.com/api/micah/${user.name}.svg"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: Text(
                            user.address.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down_sharp)
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
                          type: PageTransitionType.rightToLeft,
                          child: CartScreen())),
                ),
              ],
            );
          }),
    );
  }
}
