abstract class UserRepository {
  const UserRepository();

  String get phoneNumber;

  Future<String> authenticate(String phone);

  Future<String> numberAuthenticate(String verificationId, String smsCode);

  //Future<bool> register(String phone);

  Future<void> logout();
}
