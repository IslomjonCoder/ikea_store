import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/provider/products_provider.dart';
import 'package:ikea_store/ui/widgets/universal_widget/custom_button.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key? key, required this.product}) : super(key: key);
  ProductModel product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    print(widget.product.comments);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.arrowBack),
        ),
        title: const Text('Product Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: widget.product.id,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.background1), fit: BoxFit.cover),
              ),
              height: 300,
              child: CachedNetworkImage(
                imageUrl: widget.product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        Ink(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.cE0E0E0,
                          ),
                          child: InkWell(
                            onTap: (count == 0)
                                ? null
                                : () {
                                    setState(() {
                                      count--;
                                    });
                                  },
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          count.toString(),
                          style: AppStyle.title,
                        ),
                        const SizedBox(width: 15),
                        Ink(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.cE0E0E0,
                          ),
                          child: InkWell(
                            onTap: (count == widget.product.count)
                                ? null
                                : () {
                                    setState(() {
                                      count++;
                                    });
                                  },
                            child: const Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppImages.star2),
                        const SizedBox(width: 10),
                        Text(widget.product.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.review, arguments: widget.product);
                          },
                          child: Text(
                            "(${widget.product.comments?.length ?? 0} reviews)",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.c808080),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'In Stock: ${widget.product.count}',
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product.description,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.c606060),
                ),
                const SizedBox(height: 16),
                CustomButton(
                    name: 'Add to cart',
                    onTap: () {
                      Provider.of<ProductsProvider>(context, listen: false)
                          .addToCard(context: context, product: widget.product, count: count);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
