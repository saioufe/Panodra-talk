import 'package:pandora_talks/repository/user_repository.dart';

class TestUserRepository extends UserRepository {
  final String fakePhone;
  final bool succ;

  const TestUserRepository({this.fakePhone, this.succ});

  @override
  Future<String> authenticate(String phone) {
    return Future<String>.delayed(const Duration(seconds: 1), succ.toString);
  }

  @override
  Future<String> numberAuthenticate(String verificationId, String smsCode) {
    return Future<String>.delayed(const Duration(seconds: 1), succ.toString);
  }

  @override
  Future<void> logout() => Future.delayed(const Duration(seconds: 1));

  @override
  String get phoneNumber => fakePhone;
}
