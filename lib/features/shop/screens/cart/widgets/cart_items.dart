import 'package:fashion_star_shop/common/widgets/products/cart/add_remove_button.dart';
import 'package:fashion_star_shop/common/widgets/products/cart/cart_item.dart';
import 'package:fashion_star_shop/common/widgets/texts/price_text.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButton=true});

  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (_, index) => Column(
        children: [
          const TCartItem(),
          if(showAddRemoveButton)SizedBox(height: TSizes.spaceBtwItems),
          if(showAddRemoveButton) const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [SizedBox(width: 70,),

                TProductQuantityWithAddRemoveButton(),],),
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
