import 'package:flutter/material.dart';
import 'package:ikea_store/service/auth_service/authentication.dart';
import 'package:ikea_store/ui/admin/category/view/category_screen.dart';
import 'package:ikea_store/ui/admin/product/view/products_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin page'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminProductsScreen(),
                      ));
                },
                child: const Text('Products')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminCategoryScreen(),
                      ));
                },
                child: const Text('Categories')),
          ],
        ),
      ),
    );
  }
}
