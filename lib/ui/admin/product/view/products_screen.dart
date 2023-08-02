import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/ui/admin/product/controller/products_controller.dart';
import 'package:ikea_store/ui/admin/product/view/add_product_screen.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:provider/provider.dart';

class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProductsController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: AppColors.dark)),
        title: const Text("Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductScreen(),
                    ));
              },
              icon: const Icon(
                Icons.add,
                color: AppColors.dark,
              ))
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .snapshots()
            .map((event) => event.docs.map((e) => ProductModel.fromJson(e.data())).toList()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final List<ProductModel> products = snapshot.data!;
            return (products.isEmpty)
                ? const Center(child: Text('Products is empty'))
                : ListView.separated(
                    itemBuilder: (context, index) {
                      ProductModel product = products[index];
                      return ListTile(
                        title: Text(product.name),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: products.length);
          }
          return Center(child: Text(snapshot.connectionState.name));
        },
      ),
    );
  }
}
