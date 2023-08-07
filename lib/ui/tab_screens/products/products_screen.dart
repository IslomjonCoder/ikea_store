import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/provider/products_provider.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _opacityAnimation;
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))..forward();
    _opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Make home',
              style: AppStyle.title.copyWith(fontSize: 14, color: AppColors.c909090, fontWeight: FontWeight.w400),
            ),
            Text(
              'BEAUTIFUL',
              style: AppStyle.title.copyWith(
                fontSize: 18,
                color: AppColors.c303030,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ListView.separated(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  provider.setCategory = index;
                  pageController.animateToPage(
                    provider.selectedCategory,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.linear,
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: (index == 0) ? AppColors.c303030 : AppColors.cF5F5F5,
                        ),
                        height: 44,
                        width: 44,
                        child: (index == 0)
                            ? SvgPicture.asset(AppImages.star)
                            : CachedNetworkImage(
                                imageUrl: provider.categories[index].imageUrl,
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AnimatedDefaultTextStyle(
                      style: AppStyle.body2.copyWith(
                        fontWeight: (provider.selectedCategory == index) ? FontWeight.w600 : FontWeight.w400,
                        color: (provider.selectedCategory == index) ? AppColors.c242424 : AppColors.c999999,
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: Text(provider.categories[index].name),
                    )
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 25,
              ),
              itemCount: provider.categories.length,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                // print(value);
                provider.setCategory = value;
                scrollController.animateTo(provider.selectedCategory * 70,
                    duration: const Duration(milliseconds: 500), curve: Curves.linear);
              },
              itemCount: provider.categories.length,
              itemBuilder: (BuildContext context, int index) {
                print(index);
                List<ProductModel> products = provider.getProductByCategory(index);
                print(products.length);

                return GridView.builder(
                  itemCount: products.length,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (context, index) {
                    // provider.products.length;
                    final product = products[index];
                    return FadeTransition(
                      opacity: _opacityAnimation,
                      child: ProductWiget(
                        product: product,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.detailProduct,
                            arguments: product,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // body: StreamBuilder(stream: ,),
    );
  }
}

class ProductWiget extends StatelessWidget {
  ProductWiget({
    super.key,
    required this.product,
    this.onTap,
  });

  final ProductModel product;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: product.id,
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(AppImages.background1),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            "\$ ${product.price.toStringAsFixed(2)}",
            style: AppStyle.body2.copyWith(fontWeight: FontWeight.w700, color: AppColors.c303030),
          ),
        ],
      ),
    );
  }
}
