part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class OrderSaving extends CheckoutState {}

// ignore: must_be_immutable
class OrderSaved extends CheckoutState {
  // ignore: non_constant_identifier_names
  String order_id;
  OrderSaved({
    // ignore: non_constant_identifier_names
    @required this.order_id,
  });
}

class OrderErrorOccured extends CheckoutState {
  final CustomException exception;
  OrderErrorOccured({
    @required this.exception,
  });
}
