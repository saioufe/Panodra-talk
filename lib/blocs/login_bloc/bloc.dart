import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pandora_talks/repository/user_repository.dart';

import '../authentication_bloc.dart';
import '../login_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent e) async* {
    if (e is LoginButtonPressed) {
      yield* _loginPressed(e);
    }
  }

  Stream<LoginState> _loginPressed(LoginEvent e) async* {
    yield const LoginLoading();

    try {
      await userRepository.authenticate(e.phone);

      authenticationBloc.add(LoggedIn());
      yield const LoginInitial();
    } on PlatformException {
      yield const LoginFailure();
    }
  }
}
