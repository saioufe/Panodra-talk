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
      await FirebaseAuth.instance.signInWithPhoneNumber(phone);

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  @override
  Future<void> logout() => FirebaseAuth.instance.signOut();
}
