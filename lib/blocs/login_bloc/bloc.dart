import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pandora_talks/repository/user_repository.dart';

import '../authentication_bloc.dart';
import '../login_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({this.userRepository, this.authenticationBloc})
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
        yield const LoginAuthentication();
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
    var firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('Users ');

    yield const LoginLoading();

    try {
      final succes =
          await userRepository.numberAuthenticate(e.verificationId, e.sms);

      print("user had loggedIn");

      if (succes == "yes") {
        await users.where("phone", isEqualTo: e.phone).get().then((value) {
          print("this is the length : " + value.docs.length.toString());

          if (value.docs.length == 0) {
            users.add({
              'phone': e.phone,
            }).then((value) => print("User Added"));
          }
        });

        authenticationBloc.add(LoggedIn());
        yield const LoginInitial();
      } else if (succes == "no") {
        yield const LoginFailure();
        print("user had loggedOut");
        yield const LoginFailure();
      }
    } on FirebaseAuthException catch (e) {
      print("error is  : " + e.toString());
      yield const LoginFailure();
    }
  }
}
