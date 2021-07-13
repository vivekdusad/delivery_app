import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final Cart cartprovider = watch(cartProvider);
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
          child: ListView.builder(
            itemCount: cartprovider.getProducts.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(cartprovider.getProducts[index].id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    cartprovider.removeFromCart(
                        cartprovider.getProducts.elementAt(index));
                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(cart: cartprovider.getProducts[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}
