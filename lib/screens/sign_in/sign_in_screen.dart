import 'package:delivery_app/auth/bloc/authentication_bloc.dart';
import 'package:delivery_app/helper/userrepositry.dart';
import 'package:delivery_app/screens/otp/otp_screen.dart';
import 'package:delivery_app/screens/sign_in/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  SignInScreen({Key key}) : super(key: key);
  static Page page() => MaterialPage<void>(child: SignInScreen());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is Unauthenticated) {
                return Body();
              } else if (state is OtpSentState || state is OtpExceptionState) {
                return OtpScreen();
              } else if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoginCompleteState) {}
              return Body();
            },
          ),
        ),
      ),
    );
  }
}
