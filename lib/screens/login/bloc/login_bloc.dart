import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/custom_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    final provider = ProviderContainer().read(phoneauth);
    if (event is LoginRequested) {
      try {
        await provider.verifyPhone(event.phone);
        yield LoginSucess();
      } on SocketException catch (e) {
        print(e);
        yield LoginFailed(
            exception: CustomException(message: "Internet Error", path: ""));
      } on FirebaseAuth catch (e) {
        yield LoginFailed(
            exception: CustomException(message: e.languageCode, path: ""));
      } on FirebaseException catch (e) {
        yield LoginFailed(
            exception: CustomException(message: e.message, path: ""));
      } catch (e) {
        yield LoginFailed(
            exception:
                CustomException(message: "Something Wrong Happened", path: ""));
      }
    } else if (event is VerifyOtp) {
      try {
        await provider.signIn(smsOTP: event.otp);
        yield LoginSucess();
      } on SocketException catch (e) {
        print(e);
        yield LoginFailed(
            exception: CustomException(message: "Internet Error", path: ""));
      } on FirebaseAuth catch (e) {
        yield LoginFailed(
            exception: CustomException(message: e.languageCode, path: ""));
      } on FirebaseException catch (e) {
        yield LoginFailed(
            exception: CustomException(message: e.message, path: ""));
      } catch (e) {
        yield LoginFailed(
            exception:
                CustomException(message: "Something Wrong Happened", path: ""));
      }
    }
  }
}
