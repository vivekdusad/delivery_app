import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoLocation extends StatelessWidget {
  const NoLocation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: Lottie.network(
                "https://assets9.lottiefiles.com/private_files/lf30_D4yZiV.json",
                animate: true)),
        Text(
          "Sorry We Haven't Reached Your Location Yet!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
