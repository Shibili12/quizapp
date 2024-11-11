part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
   final LoginModel loginModel; // Add student ID

  LoginSuccess(this.loginModel);
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
