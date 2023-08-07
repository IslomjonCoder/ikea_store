import 'package:flutter/material.dart';
import 'package:ikea_store/ui/tab_screens/bookmark/view/favourites_screen.dart';
import 'package:ikea_store/ui/tab_screens/card/card_page.dart';
import 'package:ikea_store/ui/tab_screens/products/products_screen.dart';
import 'package:ikea_store/ui/tab_screens/settings/setting_page.dart';

class HomeScreenProvider extends ChangeNotifier {
  int selected = 0;

  final List<Widget> pages = [
    const ProductsScreen(),
    const CardPage(),
    const FavouritesScreen(),
    const SettingPage()
  ];

  set setSelect(index) {
    selected = index;
    notifyListeners();
  }
}
