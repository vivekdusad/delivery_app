import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/Product.dart';

part 'results_event.dart';
part 'results_state.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  final Database database;
  ResultsBloc(
    this.database,
  ) : super(ResultsInitial());

  @override
  Stream<ResultsState> mapEventToState(
    ResultsEvent event,
  ) async* {
    if (event is ResultLoad) {
      yield ResultsLoading();
      try {
        Stream<List<Product>> data = database.readProducts(event.path);
        yield ResultsLoaded(products: data);
      } catch (e) {
        ResultsErrorOccured(message: e.toString());
      }
    }else if (event is SearchResultLoad) {
      yield ResultsLoading();
      try {
        Stream<List<Product>> data = database.getSuggestions(event.query);
        yield ResultsLoaded(products: data);
      } catch (e) {
        ResultsErrorOccured(message: e.toString());
      }
    }
  }
}
