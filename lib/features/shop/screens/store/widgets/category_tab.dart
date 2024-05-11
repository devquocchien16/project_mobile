import 'package:fashion_star_shop/common/widgets/brands/brand_show_case.dart';
import 'package:fashion_star_shop/common/widgets/layouts/grid_layout.dart';
import 'package:fashion_star_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:fashion_star_shop/common/widgets/texts/section_heading.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const TBrandShowcase(images: [TImages.productImage3, TImages.productImage4, TImages.productImage5]),
            const TBrandShowcase(images: [TImages.productImage3, TImages.productImage4, TImages.productImage5]),
            const SizedBox(height: TSizes.spaceBtwItems,),


            TSectionHeading(title: "You might like", onPressed: (){},),
            const SizedBox(height: TSizes.spaceBtwItems,),
            // TGridLayout(itemCount: 4, itemBuilder: (_, index) => TProductCardVertical()),
            // const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),)
      ],
    );
  }
}
