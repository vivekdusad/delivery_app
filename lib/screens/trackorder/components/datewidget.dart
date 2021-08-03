import 'package:flutter/material.dart';



class DateWidget extends StatelessWidget {
  const DateWidget({
    Key key,
  }) : super(key: key);

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