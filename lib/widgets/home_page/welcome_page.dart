import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc/bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined),
            onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(
              LoggedOut(),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text("You're logged in"),
      ),
    );
  }
}
