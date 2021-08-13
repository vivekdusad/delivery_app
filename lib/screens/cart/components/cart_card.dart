import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../constants/size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cart,
    @required this.quantity,
  }) : super(key: key);

  final Product cart;
  final quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
                padding:
                    EdgeInsets.all(getProportionateScreenWidth(10, context)),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CachedNetworkImage(
                  imageUrl: cart.image_url,
                )),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.name,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\₹${cart.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x$quantity",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
