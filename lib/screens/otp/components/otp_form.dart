import 'package:delivery_app/constants/provider.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

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
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 20,
            style: TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.box,
            onCompleted: (pin) {
              otp = pin;
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () {
              ProviderContainer().read(phoneauth).signIn(context, smsOTP: otp);
            },
          )
        ],
      ),
    );
  }
}
