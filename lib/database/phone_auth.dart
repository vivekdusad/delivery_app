import 'package:delivery_app/constants/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class PhoneAuth {
  String verificationId;
  String errorMessage = '';
  // For firebase auth
  final auth = FirebaseAuth.instance;

  PhoneAuth();
//
  Future<void> verifyPhone(String phoneNum) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      await auth.signInWithCredential(phoneAuthCredential);
      // Todo After Verification Complete
      // Navigator.of(context).pop();
    };
//
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Auth Exception is ${authException.message}');
    };
//
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print('verification id is $verificationId');
      this.verificationId = verificationId;
      final provider = ProviderContainer().read(otpsentprovider);
      provider.updateValue(true);
      print(provider.valueNotifier.value);
    };
//
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };
//
    await auth.verifyPhoneNumber(
      // mobile no. with country code
      phoneNumber: "+91" + phoneNum,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  signIn({@required String smsOTP}) {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      auth.signInWithCredential(credential);
      // Todo After Verification Complete
      // Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signout() async {
    await auth.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  
}
