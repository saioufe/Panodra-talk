import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  const LoggedIn();
}

class LoggedOut extends AuthenticationEvent {
  const LoggedOut();
}
