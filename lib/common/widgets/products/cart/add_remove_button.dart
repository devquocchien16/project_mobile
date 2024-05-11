import 'package:fashion_star_shop/common/widgets/icon/circular_icon.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TCircularIcon(
              icon: Iconsax.minus,
              width: 32,
              height: 32,
              size: TSizes.md,
              color: THelperFunctions.isDarkMode(context) ? Colors.white : Colors.black,
              backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              '2',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            TCircularIcon(
              icon: Iconsax.add,
              width: 32,
              height: 32,
              size: TSizes.md,
              color: Colors.white,
              backgroundColor: TColors.primary,
            ),
          ],
        );

  }
}
