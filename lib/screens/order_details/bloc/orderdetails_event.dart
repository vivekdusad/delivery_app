part of 'orderdetails_bloc.dart';

abstract class OrderdetailsEvent extends Equatable {
  const OrderdetailsEvent();

  @override
  List<Object> get props => [];
}

class CancelOrder extends OrderdetailsEvent {
  final String orderId;
  CancelOrder({this.orderId});
}
