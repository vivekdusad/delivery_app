import 'package:flutter/material.dart';
import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/constants/size_config.dart';


// ignore: must_be_immutable
class OtpForm extends StatefulWidget {
  TextEditingController otpController;
  OtpForm({Key key, @required this.otpController}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String otp;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () {
              
            },
          )
        ],
      ),
    );
  }
}
