import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/components/product_card.dart';
import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ResultsPage extends StatelessWidget {
  final String path;
  const ResultsPage({Key key, this.path}) : super(key: key);
  static String routeName = "/results";

  @override
  Widget build(BuildContext context) {
    print(path);
    return Consumer(builder: (context, watch, child) {
      return Scaffold(
        appBar: AppBar(),
        body: PaginateFirestore(
          itemBuilder: (index, context, documentSnapshot) {
            final data = documentSnapshot.data() as Map;
            final product = Product.fromMap(data);
            return ProductCard(product: product);
          },
          query: FirebaseFirestore.instance
              .collection(ApiPath.products)
              .where('category', isEqualTo: path)
              .orderBy('name'),
          itemBuilderType: PaginateBuilderType.listView,
          isLive: true,
        ),
      );
    });
  }
}
/*BlocBuilder<ResultsBloc, ResultsState>(
          bloc: resultBloc,
          builder: (context, state) {
            print(state);
            if (state is ResultsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ResultsLoaded) {
              return Body(product: state.products, path: path);
            } else if (state is ResultsErrorOccured) {
              print("error");
              return CustomErrorWidget(
                exception: state.exception,
              );
            }
            return Container(
              color: Colors.red,
            );
          },
        ),
        
*/