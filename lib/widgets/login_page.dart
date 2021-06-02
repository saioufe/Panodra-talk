import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc/bloc.dart';
import 'package:pandora_talks/blocs/login_bloc.dart';
import 'package:pandora_talks/repository/user_repository/phone_repository.dart';

import 'main_page/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();
  @override
  Widget build(BuildContext context) {
    final repository = context.select((PhoneUserRepository r) => r);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: BlocProvider(
        child: const LoginForm(),
        create: (context) =>
            LoginBloc(userRepository: repository, authenticationBloc: authBloc),
      ),
    );
  }
}
