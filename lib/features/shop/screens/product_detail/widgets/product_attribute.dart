import 'package:flutter/material.dart';
import 'package:fashion_star_shop/common/widgets/chips/choice_chip.dart';
import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fashion_star_shop/common/widgets/texts/price_text.dart';
import 'package:fashion_star_shop/common/widgets/texts/product_title_text.dart';
import 'package:fashion_star_shop/common/widgets/texts/section_heading.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  TSectionHeading(title: 'Variation', showActionButton: false),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$25',
                          style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        const TProductPriceText(price: '20'),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const TProductTitleText(title: 'Stock', smallSize: true),
                  Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              TProductTitleText(
                title: 'This is the Description of the Product and it can go up to max 4 Lines',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TSectionHeading(title: "Colors"),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Wrap(
          children: [
            TChoiceChip(text: "Green", selected: false, onSelected: (value) {}),
            TChoiceChip(text: "Blue", selected: false, onSelected: (value) {}),
            TChoiceChip(text: "Red", selected: false, onSelected: (value) {}),
            TChoiceChip(text: "Yellow", selected: false, onSelected: (value) {}),
            TChoiceChip(text: "Black", selected: false, onSelected: (value) {}),
            TChoiceChip(text: "White", selected: false, onSelected: (value) {}),
          ],
        ),
        TSectionHeading(title: "Sizes"),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Wrap(
          children: [
            TChoiceChip(text: "EU-34", selected: true, onSelected: (value) {}),
            TChoiceChip(text: "EU-36", selected: false, onSelected: (value) {}),
            TChoiceChip(text: "EU-38", selected: false, onSelected: (value) {}),
            TChoiceChip(text: "EU-40", selected: false, onSelected: (value) {}),
            TChoiceChip(text: "EU-41", selected: false, onSelected: (value) {}),
            TChoiceChip(text: "EU-42", selected: false, onSelected: (value) {}),
          ],
        ),


      ],
    );
  }
}
