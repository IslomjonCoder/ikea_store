import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/provider/products_provider.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    print(provider.cartItems.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My cart'),
      ),
      body: (provider.cartItems.isEmpty)
          ? const Center(child: Text('Cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: provider.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = provider.cartItems[index];
                      return SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              child: CachedNetworkImage(
                                imageUrl: cartItem.product.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          cartItem.product.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          // maxLines: 1,
                                          style: AppStyle.body2.copyWith(color: AppColors.c999999),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            provider.deleteCartItem(cartItem);
                                          },
                                          child: SvgPicture.asset(
                                            AppImages.clear,
                                            height: 24,
                                            width: 24,
                                          ))
                                    ],
                                  ),
                                  Text(
                                    '\$ ${cartItem.product.price.toStringAsFixed(2)}',
                                    style: AppStyle.subtitle1
                                        .copyWith(color: AppColors.c242424, fontWeight: FontWeight.w700),
                                  ),
                                  const Spacer(),
                                  // const SizedBox(height: 23),
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
                                          onTap: () {
                                            if (cartItem.count > 0) {
                                              provider.updateCartItemCount(cartItem, cartItem.count - 1);
                                            }
                                          },
                                          child: const Icon(Icons.remove),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        cartItem.count.toString(),
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
                                          onTap: () {
                                            if (cartItem.count < cartItem.product.count) {
                                              provider.updateCartItemCount(cartItem, cartItem.count + 1);
                                            }
                                          },
                                          child: const Icon(Icons.add),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total:",
                          style: AppStyle.title.copyWith(fontWeight: FontWeight.w700, color: AppColors.c808080)),
                      Text(provider.totalPrice.toStringAsFixed(2),
                          style: AppStyle.title.copyWith(fontWeight: FontWeight.w700, color: AppColors.c303030)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
