import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  final String phone;
  final String verificationId;
  final String sms;
  const LoginEvent(this.phone, this.verificationId, this.sms);

  @override
  List<Object> get props => [phone, verificationId, sms];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({
    @required String phone,
  }) : super(phone, "0", "0");
}

class AuthButtonPressed extends LoginEvent {
  const AuthButtonPressed({
    @required String smsCode,
    @required String verificationId,
  }) : super("0", verificationId, smsCode);
}
