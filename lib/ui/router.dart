import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/ui/admin/admin_page.dart';
import 'package:ikea_store/ui/auth/welcome/welcome_screen.dart';
import 'package:ikea_store/ui/home_screen.dart';

class RouterApp extends StatefulWidget {
  const RouterApp({Key? key}) : super(key: key);

  @override
  State<RouterApp> createState() => _RouterAppState();
}

class _RouterAppState extends State<RouterApp> {
  User? user;
  StreamSubscription<User?>? _authStateSubscription;

  @override
  void initState() {
    super.initState();
    _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen(updateUserState);
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }

  updateUserState(e) {
    setState(() {
      user = e;
    });
    print(user?.email);
  }

  @override
  Widget build(BuildContext context) {
    return (user == null)
        ? const WelcomeScreen()
        : (user!.email == 'email@gmail.com')
            ? const AdminScreen()
            : const HomeScreen();
  }
}
