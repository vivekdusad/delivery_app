part of 'results_bloc.dart';

abstract class ResultsState extends Equatable {
  const ResultsState();

  @override
  List<Object> get props => [];
}

class ResultsInitial extends ResultsState {}

class ResultsLoading extends ResultsState {}

class ResultsLoaded extends ResultsState {
  final Stream<List<Product>> products;
  ResultsLoaded({this.products});
}

class ResultsErrorOccured extends ResultsState {
  final String message;
  ResultsErrorOccured({this.message});
}
