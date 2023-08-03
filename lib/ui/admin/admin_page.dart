import 'package:flutter/material.dart';
import 'package:ikea_store/ui/admin/category/view/categories.dart';
import 'package:ikea_store/ui/admin/product/view/products.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int selected = 0;
  List<Widget> pages = [const ProductsPage(), const CategoryPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selected],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
        ],
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
          });
        },
      ),
    );
  }
}
