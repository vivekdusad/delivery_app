import 'dart:async';
import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/helper/keyboard.dart';
import 'package:delivery_app/screens/login/bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_number/mobile_number.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  int count = 0;
  TextEditingController _phoneController = TextEditingController();
  List<SimCard> _simCard = <SimCard>[];
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  String smsCode = "";

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        print("permission granted");
      } else {
        MobileNumber.requestPhonePermission;
      }
    });
  }

  Future<String> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return "";
    }
    try {
      _simCard = (await MobileNumber.getSimCards);
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
    if (!mounted) return "";
    if (_simCard.isNotEmpty) {
      // _mobileNumber = _simCard.map((e) => e.number).toList();
    }
    return _simCard.first.number;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: initMobileNumberState(),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasData) {
          final phone = snapshot.data;
          count++;
          if (phone.isNotEmpty && count == 1) {
            _phoneController.value = TextEditingValue(text: phone.substring(2));
          }
        }
        return Form(
          key: _formKey,
          child: Column(
            children: [
              buildEmailFormField(snapshot.data),
              SizedBox(height: getProportionateScreenHeight(30, context)),
              // FormError(errors: errors),
              CustomDivider(),
              SizedBox(height: getProportionateScreenHeight(10, context)),
              OtpTextField(
                numberOfFields: 6,
                borderColor: Colors.black,
                // enabled: !wait,
                focusedBorderColor: kPrimaryColor,
                textStyle: TextStyle(color: Colors.black, fontSize: 20),
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  smsCode = verificationCode;
                },
              ),
              SizedBox(height: getProportionateScreenHeight(20, context)),
              DefaultButton(
                text: "Verify",
                press: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    KeyboardUtil.hideKeyboard(context);
                    if (smsCode.isNotEmpty) {
                      ProviderContainer()
                          .read(loginblocprovider)
                          .add(VerifyOtp(otp: smsCode));
                    } else {
                      print("Fill Otp");
                    }
                  }
                },
              ),
              SizedBox(height: getProportionateScreenHeight(10, context)),
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: "Send OTP again in ",
                    style: TextStyle(fontSize: 16, color: kTextColor),
                  ),
                  TextSpan(
                    text: "00:$start",
                    style: TextStyle(fontSize: 16, color: kPrimaryColor),
                  ),
                  TextSpan(
                    text: " sec ",
                    style: TextStyle(fontSize: 16, color: kTextColor),
                  ),
                ],
              )),
            ],
          ),
        );
      },
    );
  }

  TextFormField buildEmailFormField(String phone) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _phoneController,
      onChanged: (value) {
        if (value.isNotEmpty) {}
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: wait
              ? null
              : () async {
                  setState(() {
                    start = 30;
                    wait = true;
                    buttonName = "Resend";
                  });
                  ProviderContainer()
                          .read(loginblocprovider)
                          .add(LoginRequested(phone: _phoneController.text));
                  startTimer();
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Text(
              buttonName,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        labelText: "Phone",
        hintText: "Enter your Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey,
            margin: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
        Text(
          "Enter 6 digit OTP",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey,
            margin: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ],
    );
  }
}
