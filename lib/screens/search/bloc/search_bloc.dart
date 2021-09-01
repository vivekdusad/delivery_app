import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/helper/search_history.dart';
import 'package:delivery_app/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    final database = ProviderContainer().read(databaseProvider);
    if (event is SearchRequested) {
      yield SearchLoading();
      try {
        
        yield SearchLoaded(products: database.getSuggestions(event.query));
      } catch (e) {
        print(e);
        yield SearchFailed(e);
      }
    }
  }
}
