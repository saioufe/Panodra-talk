import 'package:flutter/material.dart';
import 'package:pandora_talks/localization/app_localization.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(AppLocalization.of(context).localize(LockKeys.hello)),
    );
  }
}
