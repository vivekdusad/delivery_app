import 'package:delivery_app/components/product_card.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/screens/results/bloc/results_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Body extends StatefulWidget {
  final List<Product> product;
  final String path;
  Body({Key key, this.product, this.path}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController controller;
  ResultsBloc resultsbloc;
  @override
  void initState() {
    resultsbloc = ProviderContainer().read(resultsblocProvider);
    _scrollListener();
    super.initState();
  }

  void _scrollListener() {
    controller = ScrollController();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        print("at the end of list");
        resultsbloc.add(ResultLoad(category: widget.path));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controller,
        itemCount: widget.product.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(20, context)),
            child: ProductCard(product: widget.product[index]),
          );
        });
  }
}
