import 'package:fashion_star_shop/common/widgets/layouts/grid_layout.dart';
import 'package:fashion_star_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Products
        // TGridLayout(
        //   itemCount: 4, // Replace B with the actual count
        //   itemBuilder: ( _, index) => const TProductCardVertical(),
        // ),
      ],
    );
  }
}
