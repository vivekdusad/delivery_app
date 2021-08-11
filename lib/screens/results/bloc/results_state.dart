part of 'results_bloc.dart';

abstract class ResultsState extends Equatable {
  const ResultsState();

  @override
  List<Object> get props => [];
}

class ResultsInitial extends ResultsState {}

class ResultsLoading extends ResultsState {}

class ResultsLoaded extends ResultsState {
  final List<Product> products;
  ResultsLoaded({this.products});
}
class ResultsLoadedStream extends ResultsState {
  final Stream<List<Product>> products;
  ResultsLoadedStream({this.products});
}

class ResultsErrorOccured extends ResultsState {
  final CustomException exception;
  ResultsErrorOccured({this.exception});
}
