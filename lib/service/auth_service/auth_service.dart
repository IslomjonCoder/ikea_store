import 'package:firebase_auth/firebase_auth.dart';
import 'package:ikea_store/service/auth_service/auth_exception_handler.dart';

class FirebaseAuthHelper {
  final _auth = FirebaseAuth.instance;
  AuthResultStatus? _status;

  Future<AuthResultStatus> createAccount(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _status = result.user != null
          ? AuthResultStatus.successful
          : AuthResultStatus.undefined;
    } on FirebaseAuthException catch (error) {
      _status = AuthExceptionHandler.handleException(error);
    }
    return _status!;
  }

  Future<AuthResultStatus> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      _status = AuthExceptionHandler.handleException(error);
    }
    return _status!;
  }

  logout() {
    _auth.signOut();
  }
}
