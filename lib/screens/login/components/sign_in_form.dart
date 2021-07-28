import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/helper/keyboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_number/mobile_number.dart';


class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _phoneController = TextEditingController();
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  List<String> _mobileNumber = [];
  List<SimCard> _simCard = <SimCard>[];

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });
    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }

    try {
      _simCard = (await MobileNumber.getSimCards);
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
    if (!mounted) return;
    if (_simCard.isNotEmpty) {
      _mobileNumber = _simCard.map((e) => e.number).toList();
    }
    print(_simCard.first.number);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (_mobileNumber.isNotEmpty) {
            print(_mobileNumber.first);
            showAboutDialog(
                context: context,
                children: _mobileNumber.map((e) => Text(e)).toList());
          }
        }
        return Form(
          key: _formKey,
          child: Column(
            children: [
              buildEmailFormField(),
              SizedBox(height: getProportionateScreenHeight(30, context)),
              // FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(20, context)),
              DefaultButton(
                text: "Verify",
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    KeyboardUtil.hideKeyboard(context);
                    ProviderContainer()
                        .read(phoneauth)
                        .verifyPhone(_phoneController.text);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _phoneController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }

        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "Enter your Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
