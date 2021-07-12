part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpEvent extends LoginEvent {
  final String mobile;

  VerifyOtpEvent({this.mobile});
}

