import 'package:delivery_app/models/order.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key key,
    this.order,
  }) : super(key: key);
 final  Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        DateTime.now().toString(),
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}
