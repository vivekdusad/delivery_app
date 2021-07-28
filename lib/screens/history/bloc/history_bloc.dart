import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/order.dart';
import 'package:equatable/equatable.dart';

part 'history_event.dart';
part 'history_state.dart';

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
        Stream<List<Order>> order = await database.getHistory();
        yield HistoryLoaded(orders: order);
      } on FirebaseException catch (e) {
        yield HistoryErrorOccured(e: e);
      }
    }
  }
}
