import 'package:delivery_app/components/loading_widget.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/screens/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/body.dart';

// ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer(builder: (context, watch, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: BlocListener<LoginBloc, LoginState>(
          bloc: watch(loginblocprovider),
          listener: (context, state) {
            if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.exception.message)),
              );
            }
          },
          child: Stack(
            children: [
              Body(),
              BlocBuilder<LoginBloc, LoginState>(
                bloc: watch(loginblocprovider),
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return CustomLoadingWidget();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
