import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/models/user.dart';
import 'package:delivery_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NamesPage extends StatefulWidget {
  const NamesPage({Key key}) : super(key: key);

  @override
  _NamesPageState createState() => _NamesPageState();
}

class _NamesPageState extends State<NamesPage> {
  bool isLoading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addresController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(10, context)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/name.svg",
                height: 200,
                width: 200,
              ),
              SizedBox(
                height: getProportionateScreenHeight(30, context),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "Enter Name"),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20, context),
              ),
              TextFormField(
                controller: _addresController,
                decoration: InputDecoration(hintText: "Enter Address"),
              ),
              SizedBox(
                height: getProportionateScreenHeight(40, context),
              ),
              DefaultButton(
                text: "Save",
                press: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await ProviderContainer().read(databaseProvider).saveUser(
                          user: Users(
                        name: _nameController.text,
                        id: "",
                        address: _addresController.text,
                        phone: "",
                      ));
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
