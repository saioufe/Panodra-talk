import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc/bloc.dart';
import 'package:pandora_talks/blocs/login_bloc/bloc.dart';
import 'package:pandora_talks/localization/app_localization.dart';
import 'package:pandora_talks/repository/user_repository.dart';
import 'package:pandora_talks/repository/user_repository/phone_repository.dart';
import 'package:pandora_talks/widgets/home_page/login_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<FirebaseApp> _initialization;
  TabController tabController;

  @override
  void initState() {
    _initialization = Firebase.initializeApp();
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void loginTransition() {
    if (tabController.index != 1) tabController.animateTo(1);
  }

  void logoutTransition() {
    if (tabController.index != 0) tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccess) {
              loginTransition();
            }

            if (state is AuthenticationRevoked) {
              logoutTransition();
            }

            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                _LoginPage(),
                _WelcomePage(),
              ],
            );
          },
        ));
  }
}

class _LoginPage extends StatelessWidget {
  const _LoginPage();
  @override
  Widget build(BuildContext context) {
    final repository = context.select((UserRepository r) => r);
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

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();
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
