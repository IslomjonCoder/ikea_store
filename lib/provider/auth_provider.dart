import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/models/result_model.dart';
import 'package:ikea_store/service/auth_service/authentication.dart';
import 'package:ikea_store/utils/ui_utils/loadings.dart';

class AuthProvider extends ChangeNotifier {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  User? user = FirebaseAuth.instance.currentUser;
  String errorMessage = '';

  final AuthenticationService _authService = AuthenticationService();

  bool _confirmPassword() {
    return password == confirmPassword;
  }

  Future<void> createAccount(context) async {
    if (_confirmPassword()) {
      showLoading(context);
      final Result result =
          await _authService.createUserWithEmailAndPassword(email, password, name);
      hideLoading(context);
      if (result.isSuccess) {
        reset();
        Navigator.pop(context);
      } else if (result.isFail) {
        errorMessage = result.errorMessage!;
        showError(context);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please confirm password')));
    }
  }

  Future<void> login(BuildContext context) async {
    showLoading(context);
    final Result result = await _authService.login(email, password);
    hideLoading(context);
    if (result.isSuccess) {
      // user = FirebaseAuth.instance.currentUser;
      reset();
      Navigator.pop(context);
    } else {
      errorMessage = result.errorMessage!;
      showError(context);
    }
  }

  Future<void> showError(BuildContext context, [String error = '']) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: Text((error.isEmpty) ? errorMessage : error),
        ),
      );

  Future<void> logout(BuildContext context) async {
    showLoading(context);
    final Result result = await _authService.logout();
    hideLoading(context);

    if (result.isSuccess) {
    } else {
      errorMessage = result.errorMessage!;
      showError(context);
    }
  }

  Future<void> loginWithGoogle(context) async {
    showLoading(context);
    final Result result = await _authService.signInWithGoogle();
    hideLoading(context);
    if (result.isSuccess) {
      user = FirebaseAuth.instance.currentUser;
      notifyListeners();
      Navigator.pop(context);
    } else {
      errorMessage = result.errorMessage!;
      showError(context);
    }
  }

  Future<void> changeUserInfo(context) async {
    showLoading(context);
    final Result result = await _authService.updateUserInfo(name, email);
    hideLoading(context);
    if (result.isSuccess) {
      reset();
      // user = FirebaseAuth.instance.currentUser;
      notifyListeners();
      Navigator.pop(context);
    } else {
      errorMessage = result.errorMessage!;
      showError(context);
    }
  }

  reset() {
    email = '';
    password = '';
    name = '';
    confirmPassword = '';
    errorMessage = '';
  }
}
