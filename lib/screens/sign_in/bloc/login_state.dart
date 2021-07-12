part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class NewUserDetected extends LoginState {}

class LoginSucessful extends LoginState {}

class LoginErrorOccured extends LoginState {
  final FirebaseAuthException authException;
  LoginErrorOccured({this.authException});
}
