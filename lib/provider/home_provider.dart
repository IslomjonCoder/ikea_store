import 'package:flutter/material.dart';
import 'package:ikea_store/ui/admin/admin_page.dart';
import 'package:ikea_store/ui/tab_screens/bookmark/view/favourites_screen.dart';
import 'package:ikea_store/ui/tab_screens/products/view/products_screen.dart';
import 'package:ikea_store/ui/tab_screens/settings/view/profile_screen.dart';

class HomeScreenProvider extends ChangeNotifier {
  int selected = 0;

  final List<Widget> pages = [
    const ProductsScreen(),
    const FavouritesScreen(),
    const ProfileScreen(),
    const AdminScreen()
  ];

  set setSelect(index) {
    selected = index;
    notifyListeners();
  }
}
