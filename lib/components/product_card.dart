import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/components/rounded_icon_btn.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/constants.dart';
import '../constants/size_config.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final cartprovider = watch(cartProvider);
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(10, context)),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: width,
              padding: EdgeInsets.all(getProportionateScreenWidth(20, context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedNetworkImage(imageUrl: product.image_url),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(color: Colors.black),
                          maxLines: 2,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.all(getProportionateScreenWidth(8, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\₹${product.price}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18, context),
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            RoundedIconBtn(
                              icon: Icons.remove,
                              press: () {
                                cartprovider.removeFromCart(product);
                              },
                            ),
                            SizedBox(width: 15),
                            RoundedIconBtn(
                              icon: Icons.add,
                              showShadow: true,
                              press: () {
                                cartprovider.addToCart(product);
                                Fluttertoast.showToast(
                                    msg: "Added",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: kPrimaryColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
