import 'package:flutter/material.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/ui/tab_screens/products/controller/products_provider.dart';
import 'package:ikea_store/service/storage_service/db_firestore.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductsProvider>(context);
    // final List<ProductModel>? products = Provider.of<List<ProductModel>?>(context);
    // final Stream<List<ProductModel>>? productsStream = provider.productsStream;
    // final Stream<List<CategoryModel>>? categoriesStream = provider.categoriesStream;
    return const Scaffold(
      body: Center(
        child: Text('Products Screen'),
      ),
    );
  }
}
