import 'package:delivery_app/models/custom_exception.dart';
import 'package:flutter/material.dart';


class CustomErrorWidget extends StatelessWidget {
  final CustomException exception;
  const CustomErrorWidget({Key key, this.exception}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(exception.message),
      ]),
    );
  }
}
