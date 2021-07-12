part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class SaveOrder extends CheckoutEvent {
  final Order order;
  SaveOrder({this.order});
}
