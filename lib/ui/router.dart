import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    // Subscribe to auth state changes and save the subscription.
    _authStateSubscription =
        FirebaseAuth.instance.authStateChanges().listen((event) {
      updateUserState(event);
    });
  }

  @override
  void dispose() {
    // Unsubscribe from the stream when the widget is disposed.
    _authStateSubscription?.cancel();
    super.dispose();
  }

  updateUserState(event) {
    print('User yangilandi -----------------------------');
    print(user == null);
    if (user == null) {
      print('user null');
    } else {
      print('user null emas');
    }

    setState(() {
      user = event;
    });

    print('user o`zgardi');
    print(user == null);
  }

  @override
  Widget build(BuildContext context) {
    return (user == null) ? WelcomeScreen() : HomeScreen();
  }
}
