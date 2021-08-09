import 'package:delivery_app/screens/favorite/components/body.dart';
import 'package:flutter/material.dart';


//!optimazation has to be done

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key key}) : super(key: key);
  static String routeName = "/favorite";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
      body: Body(),
    );
  }
}
