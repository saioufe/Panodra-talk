abstract class UserRepository {
  const UserRepository();

  String get phoneNumber;

  Future<bool> authenticate(String phone);

  //Future<bool> register(String phone);

  Future<void> logout();
}
