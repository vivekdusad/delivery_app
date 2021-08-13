import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:delivery_app/models/custom_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      print("called");
      yield ResultsLoading();
      try {
        List<Product> data = await database.readProducts(event.category);
        yield ResultsLoaded(products: data);
      } on SocketException catch (e) {
        print(e);
        yield ResultsErrorOccured(
            exception: CustomException(message: "Internet Error", path: ""));
      } on FirebaseAuth catch (e) {
        yield ResultsErrorOccured(
            exception: CustomException(message: e.languageCode, path: ""));
      } on FirebaseException catch (e) {
        yield ResultsErrorOccured(
            exception: CustomException(message: e.message, path: ""));
      } catch (e) {
        yield ResultsErrorOccured(
            exception:
                CustomException(message: "Something Wrong Happened", path: ""));
      }
    } else if (event is SearchResultLoad) {
      yield ResultsLoading();
      try {
        Stream<List<Product>> data = database.getSuggestions(event.query);
        yield ResultsLoadedStream(products: data);
      } on SocketException catch (e) {
        print(e);
        yield ResultsErrorOccured(
            exception: CustomException(message: "Internet Error", path: ""));
      } on FirebaseAuth catch (e) {
        yield ResultsErrorOccured(
            exception: CustomException(message: e.languageCode, path: ""));
      } on FirebaseException catch (e) {
        yield ResultsErrorOccured(
            exception: CustomException(message: e.message, path: ""));
      } catch (e) {
        yield ResultsErrorOccured(
            exception:
                CustomException(message: "Something Wrong Happened", path: ""));
      }
    }
  }
}
