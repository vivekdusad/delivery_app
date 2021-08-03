import 'package:delivery_app/screens/trackorder/trackorder.dart';
import 'package:flutter/material.dart';


class OrderIdWidget extends StatelessWidget {
  const OrderIdWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final TrackOrder widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Order ID : ${widget.order_id}",
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}