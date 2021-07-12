import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/order.dart';
import 'package:dio/dio.dart';
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
        Dio().post("http://192.168.0.113:3000");
        await database.saveOrder(event.order);
        yield OrderSaved();
      } on FirebaseException catch (e) {
        yield OrderErrorOccured(e: e);
      }
    }
  }
}
