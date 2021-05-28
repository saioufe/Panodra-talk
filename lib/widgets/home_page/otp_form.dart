import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc.dart';
import 'package:pandora_talks/blocs/login_bloc/bloc.dart';
import 'package:pandora_talks/blocs/login_bloc/events.dart';
import 'package:pandora_talks/blocs/login_bloc/states.dart';
import 'package:pandora_talks/repository/user_repository/phone_repository.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:toast/toast.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen(this.phoneNumber);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();

    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String phoneNumber = "0";
  String verificationId = "0";
  bool counterFinished = false;
  @override
  Widget build(BuildContext context) {
    final repository = context.select((PhoneUserRepository r) => r);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.phoneNumber),
      ),
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Enter the code sent to ",
                      children: [
                        TextSpan(
                            text: "${widget.phoneNumber}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,

                      animationType: AnimationType.fade,
                      // validator: (v) {
                      //   if (v.length < 3) {
                      //     return "I'm from validator";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        // borderRadius: BorderRadius.circular(5),
                        //fieldHeight: 50,
                        // fieldWidth: 40,
                        activeFillColor:
                            hasError ? Colors.blue.shade100 : Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      //enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      // boxShadows: [
                      //   BoxShadow(
                      //     offset: Offset(0, 1),
                      //     color: Colors.black12,
                      //     blurRadius: 10,
                      //   )
                      // ],
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  counterFinished
                      ? BlocProvider<LoginBloc>(
                          create: (_) => LoginBloc(
                              userRepository: repository,
                              authenticationBloc: authBloc),
                          child: BlocConsumer<AuthenticationBloc,
                              AuthenticationState>(
                            builder: (ctx, state) {
                              if (state is AuthenticationSendCode) {
                                phoneNumber = state.phone;
                                verificationId = state.verificationId;
                              }

                              return TextButton(
                                  onPressed: () => _loginButtonPressed(
                                      ctx, widget.phoneNumber),
                                  child: Text(
                                    "RESEND",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ));
                            },
                            listener: (contex, state) {
                              print("this is the state : " + state.toString());
                              if (state is LoginFailure) {
                                print("make me make me");
                                Toast.show("Something Went Wrong!", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);
                              }
                            },
                          ),
                        )
                      : Countdown(
                          seconds: 30,
                          build: (BuildContext context, double time) =>
                              RichText(
                            text: TextSpan(
                                text: "RESEDN IN : ",
                                children: [
                                  TextSpan(
                                    text: time.toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15)),
                            textAlign: TextAlign.center,
                          ),
                          interval: Duration(milliseconds: 100),
                          onFinished: () {
                            setState(() {
                              counterFinished = true;
                            });
                          },
                        ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              BlocProvider<LoginBloc>(
                create: (_) => LoginBloc(
                    userRepository: repository, authenticationBloc: authBloc),
                child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  builder: (ctx, state) {
                    if (state is AuthenticationSendCode) {
                      phoneNumber = state.phone;
                      verificationId = state.verificationId;
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 80),
                      child: ButtonTheme(
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            formKey.currentState.validate();
                            // conditions for validating
                            if (currentText.length != 6) {
                              errorController.add(ErrorAnimationType
                                  .shake); // Triggering error shake animation
                              setState(() {
                                hasError = true;
                              });
                            } else {
                              setState(
                                () {
                                  hasError = false;
                                  _authButtonPressed(
                                    ctx,
                                    currentText,
                                    verificationId,
                                  );
                                  // snackBar("OTP Verified!!");
                                },
                              );
                            }
                          },
                          child: Center(
                              child: Text(
                            "VERIFY".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
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
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _authButtonPressed(
    BuildContext context, String smsCode, String verificationId) {
  BlocProvider.of<LoginBloc>(context).add(
    AuthButtonPressed(
      smsCode: smsCode,
      verificationId: verificationId,
    ),
  );
}

void _loginButtonPressed(BuildContext context, String phone) {
  BlocProvider.of<LoginBloc>(context).add(
    LoginButtonPressed(phone: phone),
  );
}
