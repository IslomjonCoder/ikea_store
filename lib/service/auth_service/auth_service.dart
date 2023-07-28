import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ikea_store/service/auth_service/auth_exception_handler.dart';

class FirebaseAuthHelper {
  final _auth = FirebaseAuth.instance;
  AuthResultStatus? _status;

  Future<AuthResultStatus> createAccount(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user?.updateDisplayName(name);
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
      _status = AuthResultStatus.successful;
    } on FirebaseAuthException catch (error) {
      print("$error ------------------------------------");
      _status = AuthExceptionHandler.handleException(error);
    } catch (e) {
      print("$e ------------------------------------");
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status!;
  }

  Future<AuthResultStatus> logout() async {
    try {
      await _auth.signOut();
      _status = AuthResultStatus.successful;
    } on FirebaseAuthException catch (error) {
      _status = AuthExceptionHandler.handleException(error);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }

  Future<AuthResultStatus> signInWithGoogle() async {
    print('login with google service');
    try {
      print('ok1');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print('ok2');
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      print('ok3');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      print('ok4');
      await FirebaseAuth.instance.signInWithCredential(credential);

      print('ok5');
      _status = AuthResultStatus.successful;
    } on FirebaseAuthException catch (error) {
      print('error in firabse');
      _status = AuthExceptionHandler.handleException(error);
    } catch (e) {
      print('error in catch $e');

      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }
}
