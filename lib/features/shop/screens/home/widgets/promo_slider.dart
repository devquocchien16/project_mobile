import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:fashion_star_shop/common/widgets/images/images_rounded.dart';
import 'package:fashion_star_shop/features/shop/controllers/home_controller.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    Key? key,
    required this.banners,
  }) : super(key: key);

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
                  () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < banners.length; i++)
                    TCircularContainer(
                      width: 5,
                      height: 2,
                      backgroundColor: controller.carousalCurrentIndex.value == i ? TColors.primary : TColors.grey,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}