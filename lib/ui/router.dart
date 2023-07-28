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

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      updateUserState(event);
    });
    super.initState();
  }

  updateUserState(event) {
    setState(() {
      user = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (user == null) ? WelcomeScreen() : HomeScreen();
  }
}
