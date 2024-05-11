import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86, // Specify the height of the container
      child: ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // Return each category widget
          return Column(
            children: [
              Container(
                width: 56,
                height: 56,
                padding: EdgeInsets.all(TSizes.sm),
                decoration: BoxDecoration(
                  color: TColors.White,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Image(image: AssetImage(TImages.sportIcon),fit: BoxFit.cover, color: TColors.dark),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems/2),
              SizedBox(
                  width: 55,
                  child: Text('Sport', style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.White))),
            ],
          );
        },
      ),
    );
  }
}