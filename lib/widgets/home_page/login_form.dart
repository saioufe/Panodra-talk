import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pandora_talks/blocs/login_bloc/bloc.dart';
import 'package:pandora_talks/blocs/login_bloc/events.dart';
import 'package:pandora_talks/blocs/login_bloc/states.dart';
import 'package:toast/toast.dart';

class LoginForm extends StatefulWidget {
  const LoginForm();
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController phoneController;

  @override
  void initState() {
    phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();

    super.dispose();
  }

  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, data) {
      var baseWidth = 750.0;

      if (data.maxWidth >= baseWidth) {
        baseWidth = data.maxWidth / 1.4;
      }

      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Image.asset(
                "assets/images/logo.png",
                width: 100,
              ),
            ),
            IntlPhoneField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IQ',
              onChanged: (phone) {
                print(phone.completeNumber);
                phoneNumber = phone.completeNumber;
              },
              countries: ["IQ", "US"],
              autoValidate: true,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () {
                    if (!phoneNumber.isEmpty && phoneNumber != "") {
                      _loginButtonPressed(context, phoneNumber);
                    }
                  },
                  child: Text("login"),
                );
              },
              listener: (contex, state) {
                print("this is the state : " + state.toString());
                if (state is LoginFailure) {
                  print("make me make me");
                  Toast.show("Something Went Wrong!", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                }
              },
            )
          ],
        ),
      );
    });
  }
}

void _loginButtonPressed(BuildContext context, String phone) {
  BlocProvider.of<LoginBloc>(context).add(
    LoginButtonPressed(phone: phone),
  );
}
