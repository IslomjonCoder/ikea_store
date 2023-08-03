import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/service/auth_service/authentication.dart';
import 'package:ikea_store/service/storage_service/db_firestore.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:ikea_store/utils/style.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AuthenticationService().logout();
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.dark,
            )),
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addProduct);
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.dark,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: DbFirestoreService().getProductList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            List<ProductModel> products = snapshot.data!;
            return (products.isEmpty)
                ? const Center(child: Text('Products is empty'))
                : GridView.builder(
                    itemCount: products.length,
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.62,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      // print(product.imageUrl);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.detailProduct,
                            arguments: product,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Hero(
                                tag: product.id,
                                child: Container(
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAlias,
                                  decoration:
                                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl: product.imageUrl,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.name,
                              style: AppStyle.body2.copyWith(color: AppColors.c303030),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\$ ${product.price}",
                              style: AppStyle.body2
                                  .copyWith(fontWeight: FontWeight.w700, color: AppColors.c303030),
                            ),
                          ],
                        ),
                      );
                    },
                  );
          }
          return const Center(child: Text('Stream anything return'));
        },
      ),
    );
  }
}
