import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  const LoggedIn();
}

class LoggedAuth extends AuthenticationEvent {
  final String phone;
  final String verificationId;
  const LoggedAuth({
    @required this.phone,
    @required this.verificationId,
  });
}

class LoggedOut extends AuthenticationEvent {
  const LoggedOut();
}
