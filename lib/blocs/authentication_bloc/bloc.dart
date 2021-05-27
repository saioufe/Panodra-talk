import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandora_talks/repository/user_repository.dart';

import '../authentication_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(this.userRepository) : super(const AuthenticationInit());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent e) async* {
    if (e is LoggedIn) {
      yield const AuthenticationSuccess();
    }

    if (e is LoggedAuth) {
      yield AuthenticationSendCode(
        phone: e.phone,
        verificationId: e.verificationId,
      );
    }

    if (e is LoggedOut) {
      yield const AuthenticationLoading();
      await userRepository.logout();
      yield const AuthenticationRevoked();
    }
  }
}
