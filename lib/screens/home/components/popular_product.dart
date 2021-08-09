import 'package:delivery_app/components/product_card.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:flutter/material.dart';
import '../../../constants/size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20,context)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {                  
                  return ProductCard(product: demoProducts[index]);
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20,context)),
            ],
          ),
        )
      ],
    );
  }
}
