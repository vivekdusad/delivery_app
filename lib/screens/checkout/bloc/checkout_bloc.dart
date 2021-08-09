import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/order.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final Database database;
  CheckoutBloc({@required this.database}) : super(CheckoutInitial());
  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if (event is SaveOrder) {
      yield OrderSaving();
      try {
        
       // ignore: non_constant_identifier_names
       final order_id =  await database.saveOrder(event.order);
        yield OrderSaved(order_id: order_id);
      } on FirebaseException catch (e) {
        yield OrderErrorOccured(e: e);
      }
    }
  }
}
