import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/service/auth_service/auth_exception_handler.dart';
import 'package:ikea_store/service/auth_service/auth_service.dart';
import 'package:ikea_store/utils/routes.dart';

class AuthProvider extends ChangeNotifier {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  String errorMessage = '';
  bool isLoading = false;
  final FirebaseAuthHelper _authHelper = FirebaseAuthHelper();
  _confirmPassword() {
    return password == confirmPassword;
  }

  createAccount(context) async {
    if (_confirmPassword()) {
      notify();
      AuthResultStatus status =
          await _authHelper.createAccount(email, password, name);
      notify();
      if (status == AuthResultStatus.successful) {
        print('Succesfull sign up');
        Navigator.pop(context);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, RouteNames.home, (route) => false);
      } else {
        errorMessage = AuthExceptionHandler.generateExceptionMessage(status);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please confirm password')));
    }
  }

  login(BuildContext context) async {
    notify();
    AuthResultStatus status = await _authHelper.login(email, password);
    notify();
    print(status.name);
    if (status == AuthResultStatus.successful) {
      Navigator.pop(context);
      print('Navigate to homescreen');
      // Navigator.pushNamedAndRemoveUntil(
      //     context, RouteNames.home, (route) => false);
      // Navigate to Home Screen
    } else {
      errorMessage = AuthExceptionHandler.generateExceptionMessage(status);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  logout(BuildContext context) async {
    AuthResultStatus status = await _authHelper.logout();
    print(status.name);
    if (status == AuthResultStatus.successful) {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, RouteNames.welcome, (route) => false);
      // Navigate to Home Screen
    } else {
      errorMessage = AuthExceptionHandler.generateExceptionMessage(status);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  loginWithGoogle(context) async {
    print('login with google provider');
    AuthResultStatus status = await _authHelper.signInWithGoogle();
    print(status.name);
    if (status == AuthResultStatus.successful) {
      Navigator.pop(context);
      // Navigator.pushNamedAndRemoveUntil(
      //     context, RouteNames.home, (route) => false);
      // Navigate to Home Screen
    } else {
      errorMessage = AuthExceptionHandler.generateExceptionMessage(status);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  notify() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
