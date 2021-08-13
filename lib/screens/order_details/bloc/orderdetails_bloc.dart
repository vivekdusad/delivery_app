import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/custom_exception.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'orderdetails_event.dart';
part 'orderdetails_state.dart';

class OrderdetailsBloc extends Bloc<OrderdetailsEvent, OrderdetailsState> {
  OrderdetailsBloc() : super(OrderdetailsInitial());

  @override
  Stream<OrderdetailsState> mapEventToState(
    OrderdetailsEvent event,
  ) async* {
    final database  =ProviderContainer().read(databaseProvider);
    if (event is CancelOrder) {
      yield OrderCancelling();
      try {
        final uid = FirebaseAuth.instance.currentUser.uid;
        print(event.orderId);
        await FirebaseFirestore.instance
            .collection(ApiPath.orders(uid))
            .doc(event.orderId)
            .update({
          'track': "${tracks.cancelled}",
        });
        await Dio().post("https://95ac55c3b0d3.ngrok.io/cancel", data: {
      "user_id": "$uid",
      "order_id": "$event.orderId",      
      'title': "Your Order is Cancelled",
      'desc': "Order Cancel!!",
      'token': "${FirebaseMessaging.instance.getToken()}",      
    });
        yield OrderCancelled();
      } catch (e) {
        print(e.toString());
        yield OrderErrorOccured();
      }
    }
  }
}
