import 'package:delivery_app/components/product_card.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/favorite/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final favoritesbloc = watch(favoriteblocprovider);
      favoritesbloc.add(GetFavorites());
      return BlocBuilder<FavoriteBloc, FavoriteState>(
        bloc: favoritesbloc,
        builder: (context, state) {
          print(state);
          
          if (state is FavoriteLoaded) {
            return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) =>
                    ProductCard(product: state.products[index]));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    });
  }
}
