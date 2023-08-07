import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/provider/products_provider.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';

class CreateReviewPage extends StatefulWidget {
  CreateReviewPage({Key? key, required this.product}) : super(key: key);
  ProductModel product;
  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  final TextEditingController _reviewController = TextEditingController();
  double ratingValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.arrowBack),
        ),
        title: const Text('Write review'),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<ProductsProvider>(context, listen: false).addReview(
                context: context,
                message: _reviewController.text,
                value: ratingValue,
                product: widget.product,
              );
            },
            child: Text('Save', style: AppStyle.button),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              maxLines: 4,
              controller: _reviewController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(labelText: 'Review Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RatingBar.builder(
                  initialRating: ratingValue,
                  itemBuilder: (context, index) => SvgPicture.asset(AppImages.star2),
                  allowHalfRating: true,
                  itemSize: 24,
                  glow: false,
                  updateOnDrag: true,
                  onRatingUpdate: (value) {
                    setState(() => ratingValue = value);
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  '$ratingValue',
                  style: AppStyle.title,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
