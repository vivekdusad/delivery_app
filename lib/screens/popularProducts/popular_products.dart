import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/components/product_card.dart';
import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/models/product.dart';

import 'package:flutter/material.dart';

class SpecialsProducts extends StatelessWidget {
  final String query;
  const SpecialsProducts({Key key,this.query}) : super(key: key);

  Stream<List<Product>> getData() {
    final stream = FirebaseFirestore.instance
        .collection(ApiPath.products)
        .where('subcategory',isEqualTo: query)
        .snapshots();
    return stream.map(
        (event) => event.docs.map((e) => Product.fromMap(e.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(query),
      ),
      body: StreamBuilder<List<Product>>(
        stream: getData(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.hasData) {
            final list = snapshot.data;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ProductCard(product: list[index]),
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
