import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/Cart.dart';
import 'package:delivery_app/screens/cart/components/emptyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends ConsumerWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var list = watch(cartProvider).getProducts;
    return Scaffold(
      appBar: buildAppBar(
        context,list.length
      ),
      body: list.isNotEmpty?Body():EmptyScreen(),
      bottomNavigationBar:
          list.isNotEmpty ? CheckoutCard() : null,
    );
  }

  AppBar buildAppBar(BuildContext context, length) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "$length items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
