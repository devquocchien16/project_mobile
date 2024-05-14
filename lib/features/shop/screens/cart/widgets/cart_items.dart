import 'package:fashion_star_shop/common/widgets/images/images_rounded.dart';
import 'package:fashion_star_shop/common/widgets/products/cart/add_remove_button.dart';
import 'package:fashion_star_shop/common/widgets/texts/brand_title_verrified_icon.dart';
import 'package:fashion_star_shop/common/widgets/texts/price_text.dart';
import 'package:fashion_star_shop/common/widgets/texts/product_title_text.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 6,
      separatorBuilder: (_, __) =>
          const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (_, index) => Column(
        children: [
          Row(
            children: [
              TRoundedImage(
                imageUrl: TImages.productImage2,
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.darkGrey
                    : TColors.light,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ///Title, Price and Size
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TBrandTitleWithVerifiedIcon(title: 'Nike'),
                    const Flexible(
                      child: TProductTitleText(
                        title: 'Black Sports shoes',
                        maxLines: 1,
                      ),
                    ),
                    // Attributes
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Color ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: 'Green ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: 'Size ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: 'UK 08',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItems),
          if (showAddRemoveButton)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    TProductQuantityWithAddRemoveButton(),
                  ],
                ),

                ///add the button
                TProductPriceText(price: '256'),
              ],
            ),
          // Your item widgets go here
        ],
      ),
    );
  }
}
