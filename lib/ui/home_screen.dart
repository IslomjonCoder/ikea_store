import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeScreenProvider provider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
      body: provider.pages[provider.selected],
      bottomNavigationBar: FlashyTabBar(
        iconSize: 25,
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Products'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.bookmark),
            title: const Text('Favourites'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Admin'),
          ),
        ],
        selectedIndex: provider.selected,
        onItemSelected: (int value) => provider.setSelect = value,
      ),
    );
  }
}
