import 'package:flutter/material.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/ui/admin/admin_page.dart';
import 'package:ikea_store/ui/admin/category/view/add.dart';
import 'package:ikea_store/ui/admin/category/view/edit.dart';
import 'package:ikea_store/ui/admin/product/view/add.dart';
import 'package:ikea_store/ui/admin/product/view/detail_page.dart';
import 'package:ikea_store/ui/admin/product/view/edit.dart';

import 'package:ikea_store/ui/auth/sign%20in/login_screen.dart';
import 'package:ikea_store/ui/auth/sign%20up/sign_up_screen.dart';
import 'package:ikea_store/ui/auth/welcome/welcome_screen.dart';
import 'package:ikea_store/ui/home_screen.dart';

class RouteNames {
  static const String login = "/categories";
  static const String signup = "/products";
  static const String welcome = "/favourites";
  static const String home = "/home";
  static const String setting = "/setting";
  static const String admin = "/admin";

  static const String detailProduct = "/detail_product";
  static const String addProduct = "/add_product";
  static const String addCategory = "/add_category";

  static const String editProduct = "/edit_product";
  static const String editCategory = "/edit_category";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RouteNames.welcome:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case RouteNames.signup:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RouteNames.addProduct:
        return MaterialPageRoute(
          builder: (context) => const AddProductPage(),
        );
      case RouteNames.addCategory:
        return MaterialPageRoute(
          builder: (context) => const AddCategoryPage(),
        );
      case RouteNames.editProduct:
        return MaterialPageRoute(
          builder: (context) => EditProductPage(product: settings.arguments as ProductModel),
        );
      case RouteNames.editCategory:
        return MaterialPageRoute(
          builder: (context) => EditCategoryPage(category: settings.arguments as CategoryModel),
        );

      case RouteNames.detailProduct:
        return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: settings.arguments as ProductModel),
        );
      case RouteNames.admin:
        return MaterialPageRoute(builder: (context) => const AdminScreen());

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
