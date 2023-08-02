import 'package:ikea_store/models/result_model.dart';

abstract class AuthenticationApi {
  Future<Result> logout();

  Future<Result> login(String email, String password);

  Future<Result> createUserWithEmailAndPassword(String email, String password, String username);

  Future<Result> signInWithGoogle();

  Future<Result> updateUserInfo(String newUsername, String newEmail);
}
