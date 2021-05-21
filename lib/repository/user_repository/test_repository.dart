import 'package:pandora_talks/repository/user_repository.dart';

class TestUserRepository extends UserRepository {
  final String fakePhone;
  final bool succ;

  const TestUserRepository({this.fakePhone, this.succ});

  @override
  Future<bool> authenticate(String phone) {
    return Future<bool>.delayed(const Duration(seconds: 1), () => succ);
  }

  @override
  Future<void> logout() => Future.delayed(const Duration(seconds: 1));

  @override
  String get phoneNumber => fakePhone;
}
