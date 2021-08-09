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
  int count = 0;

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
        if (snapshot.hasData) {
          print(snapshot.data);
          count++;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                buildEmailFormField(snapshot.data),
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
                          .verifyPhone(context, _phoneController.text);
                    }
                  },
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  TextFormField buildEmailFormField(String phone) {
    if (phone.isNotEmpty && count == 1) {
      _phoneController.value = TextEditingValue(text: phone.substring(2));
    }
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
