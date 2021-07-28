part of 'results_bloc.dart';

abstract class ResultsEvent extends Equatable {
  const ResultsEvent();

  @override
  List<Object> get props => [];
}

class ResultLoad extends ResultsEvent {
  final String category;
  ResultLoad({this.category});
}

class SearchResultLoad extends ResultsEvent {
  final String query;
  SearchResultLoad({this.query});
}
