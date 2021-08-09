import 'package:flutter/material.dart';
import 'package:delivery_app/components/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "No Results Found",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
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
