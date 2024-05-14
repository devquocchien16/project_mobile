import 'dart:convert';

import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fashion_star_shop/features/shop/models/review.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/widgets/overall_product_rating.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/widgets/rating_bar_indicator.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:fashion_star_shop/utils/device/device_utility.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_star_shop/common/widgets/appbar/appbar.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key});

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  List<Review>? listReview;
  Future<void> loadReviews() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('reviewData');
    if (jsonString != null) {
      Iterable jsonList = json.decode(jsonString);
      setState(() {
        listReview =
            jsonList.map((jsonItem) => Review.fromJson(jsonItem)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar:
          const TAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Ratings and reviews are verified and are from people who use the same type of device that you use."),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Overall Product Ratings
              const TOverallRating(),
              TRatingBarIndicator(
                rating: 3.5,
              ),
              Text(
                '12.611',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    listReview!.map((review) => buildReview(review)).toList(),
              ),
              // const UserReviewCard(),
              // const UserReviewCard(),

              // Additional Rows and Widgets can be placed here as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReview(Review review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/user.png'), // Giả sử hình ảnh người dùng
                ),
                const SizedBox(width: 8),
                Text(
                  review.userDTO!.clientName!,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            TRatingBarIndicator(rating: review.star!.toDouble()),
            const SizedBox(width: 8),
            Text(
              DateFormat('dd MMM, yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(review.updatedAt!)),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ReadMoreText(
          review.content!,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
