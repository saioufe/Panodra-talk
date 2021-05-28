import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pandora_talks/repository/user_repository.dart';

class PhoneUserRepository extends UserRepository {
  const PhoneUserRepository();

  @override
  String get phoneNumber =>
      FirebaseAuth.instance.currentUser.phoneNumber ?? "0";

  @override
  Future<String> authenticate(String phone) async {
    var completer = Completer<String>();
    try {
      print(" start mission");

      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: 30),
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential

          await FirebaseAuth.instance.signInWithCredential(credential);
          print("verification Completed mission");
          completer.complete("yes");
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          print("verificationFailed mission");
          //  completer.completeError(("error of the code mr"));
          completer.complete("no");
          // Handle other errors
        },
        codeSent: (String verificationId, int resendToken) async {
          print("send mission");
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      completer.complete("no");
    }

    return completer.future;
  }

  @override
  Future<String> numberAuthenticate(
      String verificationId, String smsCode) async {
    var credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    // // Sign the user in (or link) with the credential
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return "yes";
    } on FirebaseAuthException {
      return "no";
    }
  }

  @override
  Future<void> logout() => FirebaseAuth.instance.signOut();
}
