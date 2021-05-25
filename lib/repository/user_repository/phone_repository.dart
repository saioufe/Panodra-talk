import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pandora_talks/repository/user_repository.dart';

class PhoneUserRepository extends UserRepository {
  const PhoneUserRepository();

  @override
  String get phoneNumber =>
      FirebaseAuth.instance.currentUser.phoneNumber ?? "0";

  @override
  Future<bool> authenticate(String phone) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential

          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }

          // Handle other errors
        },
        codeSent: (String verificationId, int resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          String smsCode = 'xxxx';

          // // Create a PhoneAuthCredential with the code
          // var credential = PhoneAuthProvider.credential(
          //     verificationId: verificationId, smsCode: smsCode);

          // // Sign the user in (or link) with the credential
          // await FirebaseAuth.instance.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
    // return false;
  }

  @override
  Future<void> logout() => FirebaseAuth.instance.signOut();
}
