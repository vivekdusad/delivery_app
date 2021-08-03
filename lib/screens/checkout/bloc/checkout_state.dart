part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class OrderSaving extends CheckoutState {}

class OrderSaved extends CheckoutState {
  String order_id;
  OrderSaved({
    @required this.order_id,
  });
}

class OrderErrorOccured extends CheckoutState {
  final FirebaseException e;
  OrderErrorOccured({
    @required this.e,
  });
}
