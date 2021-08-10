import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/custom_exception.dart';
import 'package:delivery_app/models/order.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'history_event.dart';
part 'history_state.dart';

//[] for(int i=0;i<n;i++){for(int j=0;j<n1;j++){temp.push_back(product)}}

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  Database database;
  HistoryBloc({this.database}) : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is GetHistory) {
      yield HistoryLoading();
      try {
        Stream<List<Order>> order = database.getHistory();
        yield HistoryLoaded(orders: order);
      } on SocketException catch (e) {
        yield HistoryErrorOccured(
            e: CustomException(message: "Internet Error", path: ""));
      } on FirebaseAuth catch (e) {
        yield HistoryErrorOccured(
            e: CustomException(message: e.languageCode, path: ""));
      } on FirebaseException catch (e) {
        yield HistoryErrorOccured(
            e: CustomException(message: e.message, path: ""));
      } catch (e) {
        yield HistoryErrorOccured(
            e: CustomException(message: "Something Wrong Happened", path: ""));
      }
    }
  }
}
