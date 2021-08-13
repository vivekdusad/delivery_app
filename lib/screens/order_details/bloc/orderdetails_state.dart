part of 'orderdetails_bloc.dart';

abstract class OrderdetailsState extends Equatable {
  const OrderdetailsState();

  @override
  List<Object> get props => [];
}

class OrderdetailsInitial extends OrderdetailsState {}

class OrderCancelling extends OrderdetailsState {}

class OrderCancelled extends OrderdetailsState {}

class OrderErrorOccured extends OrderdetailsState {
  final CustomException exception;
  OrderErrorOccured({this.exception});
}
