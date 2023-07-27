import 'package:flutter/foundation.dart';
import 'package:ikea_store/service/auth_service/auth_exception_handler.dart';
import 'package:ikea_store/service/auth_service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  String email = '';
  String password = '';
  String errorMessage = '';
  final FirebaseAuthHelper _authHelper = FirebaseAuthHelper();

  createAccount() async {
    AuthResultStatus status = await _authHelper.createAccount(email, password);
    if (status == AuthResultStatus.successful) {
      print('Succesfull sign up');
      // Navigate to Home Screen
    } else {
      errorMessage = AuthExceptionHandler.generateExceptionMessage(status);
    }
  }

  login() async {
    AuthResultStatus status = await _authHelper.login(email, password);
    if (status == AuthResultStatus.successful) {
      print('Succesfull login');
      // Navigate to Home Screen
    } else {
      errorMessage = AuthExceptionHandler.generateExceptionMessage(status);
    }
  }
}
