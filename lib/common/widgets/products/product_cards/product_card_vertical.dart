import 'package:fashion_star_shop/common/widgets/texts/brand_title_verrified_icon.dart';
import 'package:fashion_star_shop/features/shop/models/Product.dart';
import 'package:fashion_star_shop/features/shop/screens/product_detail/product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_star_shop/common/widgets/texts/product_title_text.dart';
import 'package:fashion_star_shop/common/styles/shadows.dart';
import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fashion_star_shop/common/widgets/icon/circular_icon.dart';
import 'package:fashion_star_shop/common/widgets/images/images_rounded.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../texts/price_text.dart';

class TProductCardVertical extends StatelessWidget {
  final Product product;
  final int productId;
  const TProductCardVertical(
      {Key? key, required this.product, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () async {
        final SharedPreferences catDetailsId =
            await SharedPreferences.getInstance();
        await catDetailsId.setInt('catDetailsId', product.id);
        Get.to(() => const ProductDetailScreen());
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.White,
        ),
        child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TRoundedContainer(
                height: 180,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Stack(
                  children: [
                    TRoundedImage(
                      imageUrl: product.mainPicture,
                      applyImageRadius: false,
                    ),
                    // Positioned(
                    //   top: 12,
                    //   child: TRoundedContainer(
                    //     radius: TSizes.sm,
                    //     backgroundColor: TColors.secondary.withOpacity(0.8),
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: TSizes.sm,
                    //       vertical: TSizes.xs,
                    //     ),
                    //     child: Text(
                    //       ' ',
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .labelLarge!
                    //           .apply(color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: TCircularIcon(
                          icon: Iconsax.heart5, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.xs),
              Padding(
                padding: EdgeInsets.only(left: TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(title: product.title, smallSize: true),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    TBrandTitleWithVerifiedIcon(title: ""), // Row

                    // Row
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // children: [
                //   const TProductPriceText(
                //     price: '35.0',
                //   ), // Text
                //   Container(
                //     decoration: const BoxDecoration(
                //       color: TColors.dark,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(TSizes.cardRadiusMd),
                //         bottomRight: Radius.circular(TSizes.productImageRadius),
                //       ), // BorderRadius.only
                //     ), // BoxDecoration
                //     child: SizedBox(
                //       width: TSizes.iconLg * 1.2,
                //       height: TSizes.iconLg * 1.2,
                //       child:
                //           Center(child: Icon(Iconsax.add, color: Colors.white)),
                //     ), // SizedBox
                //   ), // Container
                // ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
