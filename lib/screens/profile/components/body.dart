import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/user_details/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsUI()))
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              AlertDialog alert = AlertDialog(
                title: Text("Logout"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () async {
                        await ProviderContainer().read(phoneauth).signout();
                        Navigator.pop(context);
                      },
                      child: Text("Logout"))
                ],
              );
              showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  });
            },
          ),
        ],
      ),
    );
  }
}
