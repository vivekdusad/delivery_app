import 'package:delivery_app/components/coustom_bottom_nav_bar.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/screens/history/emptyScreen.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key key}) : super(key: key);
  static String routeName = "/history";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.history),
      body: EmptyScreen(),
    );
  }
}
