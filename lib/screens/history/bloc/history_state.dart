part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final Stream<List<Order>> orders;
  HistoryLoaded({this.orders});
}

class HistoryErrorOccured extends HistoryState {
  final CustomException e;

  HistoryErrorOccured({this.e});
}
