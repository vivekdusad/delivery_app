import 'package:delivery_app/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressWidget extends ConsumerWidget {
  const AddressWidget({
    this.order,
    Key key,
  }) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.home,
            size: 30.0,
          ),
          SizedBox(width: 32.0),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 20.0),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Text(
                    order.address,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
