import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc/bloc.dart';
import 'package:pandora_talks/widgets/main_page/login/otp_form.dart';
import 'package:pandora_talks/widgets/main_page/main_page.dart';
import 'package:pandora_talks/widgets/login_page.dart';

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
    tabController = TabController(length: 3, vsync: this);
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

  void sendCodeAuthTransition() {
    print("start transition");
    if (tabController.index == 0) tabController.animateTo(2);
  }

  String phoneNumber = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("something went wrong");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          // FirebaseAuth.instance.authStateChanges().listen((User user) {
          //   if (user == null) {
          //     print('User is currently signed out!');
          //   } else {
          //     print('User is signed in!');
          //   }
          // });

          var user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            tabController.animateTo(0);
          } else {
            tabController.animateTo(1);
          }
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationSuccess) {
                loginTransition();
              }

              if (state is AuthenticationRevoked) {
                logoutTransition();
              }

              if (state is AuthenticationSendCode) {
                phoneNumber = state.phone;

                sendCodeAuthTransition();
              }

              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  LoginPage(),
                  MainScreen(),
                  OtpScreen(phoneNumber, tabController),
                ],
              );
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).canvasColor),
            strokeWidth: 2,
          ),
        );
      },
    ));
  }
}
