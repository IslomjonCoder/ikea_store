import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/ui/admin/product/controller/products_controller.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.editProduct, arguments: product);
            },
            icon: const Icon(
              Icons.edit,
              color: AppColors.dark,
            ),
          ),
          IconButton(
            onPressed: () {
              Provider.of<ProductProvider>(context, listen: false).deleteProduct(context, product);
            },
            icon: const Icon(
              Icons.delete,
              color: AppColors.dark,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.arrowBack),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id,
              child: AspectRatio(
                aspectRatio: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            AppImages.background1,
                          ),
                          fit: BoxFit.cover)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    imageUrl: product.imageUrl,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
