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
      LoaderDialog.showLoadingDialog(context);
      final Result result =
          await _authService.createUserWithEmailAndPassword(email, password, name);
      LoaderDialog.hideLoadingDialog(context);
      if (result.isSuccess) {
        reset();
        Navigator.pop(context);
      } else if (result.isFail) {
        errorMessage = result.errorMessage!;
        LoaderDialog.showError(context, errorMessage);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please confirm password')));
    }
  }

  Future<void> login(BuildContext context) async {
    LoaderDialog.showLoadingDialog(context);
    final Result result = await _authService.login(email, password);
    LoaderDialog.hideLoadingDialog(context);
    if (result.isSuccess) {
      reset();
      Navigator.pop(context);
    } else {
      errorMessage = result.errorMessage!;
      LoaderDialog.showError(context, errorMessage);
    }
  }

  Future<void> logout(BuildContext context) async {
    LoaderDialog.showLoadingDialog(context);
    final Result result = await _authService.logout();
    LoaderDialog.hideLoadingDialog(context);

    if (result.isFail) {
      errorMessage = result.errorMessage!;
      LoaderDialog.showError(context, errorMessage);
    }
  }

  Future<void> loginWithGoogle(context) async {
    LoaderDialog.showLoadingDialog(context);
    final Result result = await _authService.signInWithGoogle();
    LoaderDialog.hideLoadingDialog(context);
    if (result.isSuccess) {
      Navigator.pop(context);
    } else {
      errorMessage = result.errorMessage!;
      LoaderDialog.showError(context, errorMessage);
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
