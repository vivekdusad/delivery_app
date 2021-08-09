import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NamesPage extends StatefulWidget {
  const NamesPage({Key key}) : super(key: key);

  @override
  _NamesPageState createState() => _NamesPageState();
}

class _NamesPageState extends State<NamesPage> {
  TextEditingController _addresController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(10, context)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/name.svg",
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10, context),
                  ),
                  Text("Manually Type your address or tap on Location Button"),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: _addresController,
                        decoration: InputDecoration(hintText: "Enter Address"),
                      )),
                      Container(
                        height: 100,
                        width: 100,
                        child: IconButton(
                            color: kPrimaryColor,
                            onPressed: () async {},
                            icon: SvgPicture.asset(
                                "assets/icons/Location point.svg")),
                      ),
                    ],
                  ),
                  DefaultButton(
                    text: "Save Address",
                    press: () async {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
