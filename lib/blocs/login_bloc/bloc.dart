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
      final succes =
          await userRepository.authenticate(e.phone).whenComplete(() {
        print("done ");
      }).catchError(
        (onError) {
          print("an error had accured");
        },
      );
      // .then((value)  {
      //   print("this is async*");
      //   // print("this is then  : " + value.toString());
      //   // if (value == true) {
      //   //   authenticationBloc.add(LoggedIn());
      //   //   print("you are logged in");
      //   //   yield LoginFailure();

      //   //   // yield const LoginInitial();
      //   // } else {
      //   //   authenticationBloc.add(LoggedIn());
      //   //   print("you are logged out");
      //   //   yield LoginFailure();
      //   // }
      // });

      if (succes) {
        authenticationBloc.add(LoggedIn());
        print("you are logged in");
        yield const LoginInitial();
      } else {
        yield const LoginFailure();
      }
      print("mr finish me please");

      // await userRepository.authenticate(e.phone);

    } on PlatformException {
      yield const LoginFailure();
    }
  }
}
