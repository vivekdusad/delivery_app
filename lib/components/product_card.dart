import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/components/rounded_icon_btn.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/product.dart';
// ignore: unused_import
import 'package:fluent_ui/fluent_ui.dart' as fluent;
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
  void addToCart() {}

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final cartprovider = watch(cartProvider);
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(10, context)),
      child: GestureDetector(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: width,
                      padding: EdgeInsets.all(
                          getProportionateScreenWidth(20, context)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CachedNetworkImage(imageUrl: product.image_url),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: getScreenWidth(context) - 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              product.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "\₹${product.price}",
                                style: TextStyle(
                                  fontSize:
                                      getProportionateScreenWidth(20, context),
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${product.discount}% discount",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                          !cartprovider.products.containsKey(product)
                              ? OutlinedButton(
                                  onPressed: () {
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
                                  child: Text("Add To Cart"))
                              : OutlinedButton(
                                  onPressed: null,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RoundedIconBtn(
                                        icon: Icons.remove,
                                        press: () {
                                          cartprovider.removeFromCart(product);
                                        },
                                      ),
                                      SizedBox(width: 15),
                                      Text(cartprovider.getProducts[product]
                                          .toString()),
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
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(
                    thickness: 1.5,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            if (product.bestSeller)
              Container(
                padding: EdgeInsets.all(3),
                child: Text(
                  "Best Seller",
                  style: TextStyle(color: Colors.black),
                ),
                decoration: BoxDecoration(color: Colors.yellow),
              ),
          ],
        ),
      ),
    );
  }
}
