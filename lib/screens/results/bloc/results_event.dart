part of 'results_bloc.dart';

abstract class ResultsEvent extends Equatable {
  const ResultsEvent();

  @override
  List<Object> get props => [];
}

class ResultLoad extends ResultsEvent {
  final String path;
  ResultLoad({this.path});
}
