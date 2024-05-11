import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/common/widgets/icon/circular_icon.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace,
          vertical: TSizes.defaultSpace / 2
      ),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.darkGrey,
                width: 40,
                height: 40,
                color: Colors.white, // Assuming 'iconSize' is a parameter for TCircularIcon
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),
              Text('2', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: TSizes.spaceBtwItems,),
              const TCircularIcon(
                icon: Iconsax.cloud_plus,
                backgroundColor: TColors.darkGrey,
                width: 40,
                height: 40,
                color: Colors.white, // Assuming 'iconSize' is a parameter for TCircularIcon
              ),
            ],
          ),
          ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(TSizes.md),
            backgroundColor: Colors.black,
            side: BorderSide(color: Colors.black),

          ),child: const Text('Add'),),
        ],
      ),
    );
  }
}
