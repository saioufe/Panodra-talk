import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pandora_talks/blocs/login_bloc/bloc.dart';
import 'package:pandora_talks/blocs/login_bloc/events.dart';
import 'package:pandora_talks/blocs/login_bloc/states.dart';
import 'package:toast/toast.dart';
import 'package:country_list_pick/country_list_pick.dart';

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

  String _countryCode = "+964";

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication"),
      ),
      floatingActionButton: BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).canvasColor),
              strokeWidth: 2,
            );
          }

          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                if (_key.currentState.validate()) {
                  if (!phoneController.text.isEmpty &&
                      phoneController.text != "") {
                    _loginButtonPressed(
                        context, "$_countryCode" + phoneController.text);
                  }
                }
              },
            ),
          );
        },
        listener: (contex, state) {
          if (state is LoginFailure) {
            Toast.show("Something Went Wrong!", context,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM,
                backgroundColor: Theme.of(context).primaryColor);
          }
        },
      ),
      body: LayoutBuilder(builder: (context, data) {
        var baseWidth = 750.0;

        if (data.maxWidth >= baseWidth) {
          baseWidth = data.maxWidth / 1.4;
        }

        return Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.grey))),
                  alignment: Alignment.center,
                  child: CountryListPick(
                      appBar: AppBar(
                        title: Text('Choose a country'),
                      ),
                      pickerBuilder: (context, CountryCode countryCode) {
                        return Column(
                          children: [
                            Row(
                              // ),
                              children: [
                                Text(
                                  countryCode.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        );
                      },

                      // To disable option set to false
                      theme: CountryTheme(
                        isShowFlag: true,
                        isShowTitle: true,
                        isShowCode: true,
                        isDownIcon: true,
                        showEnglishName: true,
                      ),
                      // Set default value
                      initialSelection: '+964',
                      // or
                      // initialSelection: 'US'
                      onChanged: (CountryCode code) {
                        setState(() {
                          _countryCode = code.dialCode;
                        });

                        print(code.name);
                        print(code.code);
                        print(code.dialCode);
                        print(code.flagUri);
                      },
                      // Whether to allow the widget to set a custom UI overlay
                      useUiOverlay: false,
                      // Whether the country list should be wrapped in a SafeArea
                      useSafeArea: false),
                ),
                Row(
                  // ),
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.5, color: Colors.grey))),
                        //  margin: EdgeInsets.only(top: 25),

                        child: TextField(
                          // controller: phoneController,
                          decoration: InputDecoration(
                              //  enabledBorder: InputBorder.none,
                              hintText: _countryCode,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 20)),
                          enabled: false,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Form(
                          key: _key,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "_ _ _ _ _ _ _ _",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Please confirm your country code and enter your phone number.",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

void _loginButtonPressed(BuildContext context, String phone) {
  BlocProvider.of<LoginBloc>(context).add(
    LoginButtonPressed(phone: phone),
  );
}
