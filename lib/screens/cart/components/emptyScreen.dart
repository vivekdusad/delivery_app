import 'package:delivery_app/components/default_button.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/cart.png"),
              SizedBox(
                height: 10,
              ),
              Text(
                "No orders yet",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Hit the orange button down below to Create an order"),
            ],
          ),
          DefaultButton(
            text: "Start ordering",
          ),
        ],
      ),
    );
  }
}
