import 'package:delivery_app/components/product_card.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchInitialWidget extends ConsumerWidget {
  const SearchInitialWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20, context)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: watch(historyListProvider)
                  .history
                  .map((e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(e), Icon(Icons.cancel)],
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20, context)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("assets/images/5.png")),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20, context),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Trending Products",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(200, context),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: demoProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: demoProducts[index]);
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
