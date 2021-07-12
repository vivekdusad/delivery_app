import 'package:delivery_app/components/product_card.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Stream<List<Product>> product;
  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: product,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(20)),
                  child: ProductCard(product: snapshot.data[index]),
                );
              });
        }
        if (snapshot.hasError) {
          return Container(
            child: Center(child: Text(snapshot.error.toString())),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
