import 'package:flutter/material.dart';
import 'package:delivery_app/constants/size_config.dart';

import 'components/body.dart';

class Otpscreen extends StatelessWidget {
  TextEditingController otpController;
  Otpscreen({this.otpController});
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(otpController: otpController,),
    );
  }
}
