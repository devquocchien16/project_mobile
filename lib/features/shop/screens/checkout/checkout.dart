import 'package:fashion_star_shop/features/authentication/screens/signup.widgets/success_screen.dart';
import 'package:fashion_star_shop/naviagation_menu.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:fashion_star_shop/common/widgets/appbar/appbar.dart';
import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fashion_star_shop/features/shop/screens/checkout/widgets/billing_address.dart';
import 'package:fashion_star_shop/features/shop/screens/checkout/widgets/billing_amount.dart';
import 'package:fashion_star_shop/features/shop/screens/checkout/widgets/billing_sections.dart';
import 'package:fashion_star_shop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:fashion_star_shop/common/widgets/products/cart/coupon_code.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Items in Cart
              const TCartItems(showAddRemoveButton: false),
              SizedBox(height: TSizes.spaceBtwSections /2 ),

              // Coupon TextField
              TCouponCode(dark: dark),
              SizedBox(height: TSizes.spaceBtwSections /2 ),

              // Billing Section
              // Apply solution 1: Wrap the TRoundedContainer with a Container and provide a fixed height
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? Colors.black : Colors.white,
                child: Column(
                  children: [
                    // Pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Payment Methods
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Address
                    TBillingAddressSection(),
                    // Add your widgets for Payment Methods and Address here
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => SuccessScreen(
              image: TImages.paymentSuccess,
              title: "Payment Success",
              subTitle: 'Completed Payment',
              onPressed: () => Get.to(() => const NavigationMenu()))),
          child: const Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}
