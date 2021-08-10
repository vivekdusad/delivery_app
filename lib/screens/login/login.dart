import 'package:delivery_app/components/loading_widget.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/screens/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/body.dart';

// ignore: must_be_immutable
class SignInScreen extends ConsumerWidget {
  static String routeName = "/sign_in";
  bool isLoading = false;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    SizeConfig().init(context);
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
  }
}
