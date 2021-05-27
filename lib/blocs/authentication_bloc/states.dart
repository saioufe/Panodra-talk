import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInit extends AuthenticationState {
  const AuthenticationInit();
}

class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess();
}

class AuthenticationSendCode extends AuthenticationState {
  final String phone;
  final String verificationId;
  const AuthenticationSendCode({@required this.phone, this.verificationId});
}

class AuthenticationRevoked extends AuthenticationState {
  const AuthenticationRevoked();
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}
