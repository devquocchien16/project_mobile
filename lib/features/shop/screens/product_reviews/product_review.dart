import 'package:fashion_star_shop/features/shop/screens/product_reviews/widgets/overall_product_rating.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/widgets/rating_bar_indicator.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_star_shop/common/widgets/appbar/appbar.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:flutter/widgets.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

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
              TRatingBarIndicator(rating: 3.5,),
              Text('12.611', style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              ///reviews and ratings
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),

              // Additional Rows and Widgets can be placed here as needed
            ],
          ),
        ),
      ),
    );
  }
}


