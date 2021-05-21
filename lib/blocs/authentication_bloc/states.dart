import 'package:equatable/equatable.dart';

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

class AuthenticationRevoked extends AuthenticationState {
  const AuthenticationRevoked();
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}
