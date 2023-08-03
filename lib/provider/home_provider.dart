import 'package:flutter/material.dart';
import 'package:ikea_store/ui/tab_screens/bookmark/view/favourites_screen.dart';
import 'package:ikea_store/ui/tab_screens/products/view/products_screen.dart';

class HomeScreenProvider extends ChangeNotifier {
  int selected = 1;

  final List<Widget> pages = [
    const ProductsScreen(),
    const FavouritesScreen(),
    // const ProfileScreen(),
    // const AdminScreen()
  ];

  set setSelect(index) {
    selected = index;
    notifyListeners();
  }
}
