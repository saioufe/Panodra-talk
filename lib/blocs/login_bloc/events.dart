import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  final String phone;

  const LoginEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({
    @required String phone,
  }) : super(phone);
}
