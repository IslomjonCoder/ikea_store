import 'package:flutter/material.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/style.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Make home',
              style: AppStyle.title
                  .copyWith(fontSize: 14, color: AppColors.c909090, fontWeight: FontWeight.w400),
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
      body: StreamBuilder(stream: ,),
    );
  }
}
