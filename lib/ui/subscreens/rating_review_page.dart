import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/ui/widgets/universal_widget/custom_button.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:ikea_store/utils/style.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({
    Key? key,
    required this.product,
  }) : super(key: key);
  ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.arrowBack),
        ),
        title: const Text('Rating & Review'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // physics: NeverScrollableScrollPhysics(),
              // padding: EdgeInsets.all(20),
              children: [
                SizedBox(
                  height: 100,
                  child: _headlineOfReviewPage(),
                ),
                SizedBox(height: 15),
                Divider(),
                Expanded(
                  child: (product.comments?.length) == null
                      ? const Center(
                          child: Text('Comments is not yet'),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) => ReviewWidget(
                            rating: product.comments![index].rating.toDouble(),
                            username: 'Bruno Fernandes',
                            datetime: timestampToString(product.comments![index].timestamp),
                            message: product.comments![index].comment,
                          ),
                          itemCount: product.comments?.length ?? 0,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20);
                          },
                        ),
                )
              ],
            ),
          ),
          Positioned(
              left: 20,
              right: 20,
              bottom: 35,
              child: CustomButton(
                  name: 'Write a review',
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.addReview, arguments: product);
                  })),
        ],
      ),
    );
  }

  Row _headlineOfReviewPage() {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(image: AssetImage(AppImages.background1), fit: BoxFit.cover)),
          child: CachedNetworkImage(
            imageUrl: product.imageUrl,
            // fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(product.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppStyle.body2.copyWith(color: AppColors.c242424)),
              ),
              Row(
                children: [
                  SvgPicture.asset(AppImages.star2),
                  const SizedBox(width: 10),
                  Text(product.rating.toStringAsFixed(1),
                      style: AppStyle.headline.copyWith(fontWeight: FontWeight.w700))
                ],
              ),
              Text("${product.comments?.length ?? 0} reviews",
                  style: AppStyle.title.copyWith(fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.c303030))
            ],
          ),
        )
      ],
    );
  }
}

class ReviewWidget extends StatelessWidget {
  ReviewWidget({
    required this.rating,
    required this.username,
    required this.datetime,
    required this.message,
    super.key,
  });

  double rating;
  String datetime;
  String message;
  String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: AppStyle.body2.copyWith(fontWeight: FontWeight.w600, color: AppColors.c242424),
                  ),
                  SizedBox(height: 5),
                  RatingBar.builder(
                    maxRating: 5,
                    initialRating: rating,
                    ignoreGestures: true,
                    allowHalfRating: true,
                    // updateOnDrag: false,
                    itemSize: 16,
                    itemBuilder: (context, index) => SvgPicture.asset(
                      AppImages.star2,
                      // height: 16,
                      // width: 16,
                    ),
                    onRatingUpdate: (value) {},
                  )
                ],
              ),
              Text(
                datetime,
                style: AppStyle.caption.copyWith(color: AppColors.c808080),
              )
            ],
          ),
          SizedBox(height: 15),
          Text(
            message,
            style: AppStyle.body2.copyWith(color: AppColors.c242424),
          )
        ],
      ),
    );
  }
}

String timestampToString(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String formattedDate =
      "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
  return formattedDate;
}
