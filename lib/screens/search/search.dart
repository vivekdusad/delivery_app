import 'package:flutter/material.dart';
import 'components/body.dart';

class SearchPage extends StatelessWidget {
  static String routeName = "/search";
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),      
    );
  }
}
