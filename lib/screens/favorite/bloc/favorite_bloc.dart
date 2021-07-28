import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final Database database;
  FavoriteBloc({this.database}) : super(FavoriteInitial());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is GetFavorites) {
      try {
        yield FavoriteLoading();
        List<Product> product = await database.getFavorites();
        yield FavoriteLoaded(products: product);
      } on FirebaseException catch (e) {
        print(e);
        yield FavoriteErrorOccured();
      }
    }
  }
}
