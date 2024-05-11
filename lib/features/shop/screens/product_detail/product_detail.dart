import 'package:fashion_star_shop/features/shop/models/Product.dart';
import 'package:fashion_star_shop/features/shop/screens/product_detail/widgets/bottom_add_to_cart.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/product_review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart'; // Ensure this package is included
import 'package:iconsax/iconsax.dart';
import 'package:fashion_star_shop/common/widgets/texts/section_heading.dart';
import 'package:fashion_star_shop/features/shop/screens/product_detail/widgets/product_attribute.dart';
import 'package:fashion_star_shop/features/shop/screens/product_detail/widgets/product_image_slider.dart';
import 'package:fashion_star_shop/features/shop/screens/product_detail/widgets/product_meta_data.dart';
import 'package:fashion_star_shop/features/shop/screens/product_detail/widgets/rating_share_widget.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required Product product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TProductImageSlider(dark: dark),
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  TRatingAndShare(),
                  TProductMetaData(),
                  TProductAttributes(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Checkout'),
                    ),
                  ),
                  const TSectionHeading(title: "Description"),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const ReadMoreText(
                    'This is a Product description for Blue Nike Sleeveless vest. There are more things that can be added but i',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(title: 'Reviews (199)', showActionButton: false),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () => Get.to(() => const ProductReviewsScreen()),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}