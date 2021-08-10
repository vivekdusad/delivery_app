import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/screens/order_details/components/header.dart';
import 'package:delivery_app/screens/order_details/components/items_section.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderWidget(
                      order: order,
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      color: Color(0xFFF2F2F2),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemsSection(
                      order: order,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      color: Color(0xFFF2F2F2),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      color: Colors.red,
                      text: "Cancel Order",
                      textColor: Colors.white,
                      press: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
