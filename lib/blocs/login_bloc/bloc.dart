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

    if (e is AuthButtonPressed) {
      yield* _authPressed(e);
    }
  }

  Stream<LoginState> _loginPressed(LoginEvent e) async* {
    yield const LoginLoading();

    try {
      final succes = await userRepository.authenticate(e.phone).catchError(
        (onError) {
          print("an error had accured in phone authenticate() catch Error : " +
              onError.toString());
        },
      );

      if (succes == "yes") {
        print("i'm in yes");
        authenticationBloc.add(LoggedIn());
        yield const LoginInitial();
      } else if (succes == "no") {
        print("i'm in no");
        yield const LoginFailure();
      } else {
        print("i'm in send");
        authenticationBloc.add(LoggedAuth(
          phone: e.phone,
          verificationId: succes,
        ));
      }

      // await userRepository.authenticate(e.phone);

    } on PlatformException {
      yield const LoginFailure();
    }
  }

  Stream<LoginState> _authPressed(LoginEvent e) async* {
    yield const LoginLoading();

    try {
      final succes =
          await userRepository.numberAuthenticate(e.verificationId, e.sms);

      if (succes == "yes") {
        print("user had loggedIn");
        // authenticationBloc.add(LoggedIn());
        //  yield const LoginInitial();
      } else if (succes == "no") {
        print("user had loggedOut");
        //yield const LoginFailure();
      }
    } on PlatformException {
      yield const LoginFailure();
    }
  }
}
