import 'package:flutter/material.dart';

import 'package:ikea_store/ui/auth/sign%20in/login_screen.dart';
import 'package:ikea_store/ui/auth/sign%20up/sign_up_screen.dart';
import 'package:ikea_store/ui/auth/welcome/welcome_screen.dart';
import 'package:ikea_store/ui/home_screen.dart';

class RouteNames {
  static const String login = "/categories";
  static const String signup = "/products";
  static const String welcome = "/favourites";
  static const String home = "/home";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouteNames.welcome:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case RouteNames.signup:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not found"),
            ),
          ),
        );
    }
  }
}
