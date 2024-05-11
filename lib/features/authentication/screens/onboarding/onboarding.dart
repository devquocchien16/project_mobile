import 'package:fashion_star_shop/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:fashion_star_shop/features/authentication/screens/onboarding/widgets/onboadring_page.dart';
import 'package:fashion_star_shop/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:fashion_star_shop/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:fashion_star_shop/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/constants/text_string.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scrollibale Screens
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const[
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          // Skip button
          const OnBoardingSkip(),
          // Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),
          // Circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}




