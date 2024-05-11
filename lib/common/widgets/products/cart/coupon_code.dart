import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : Colors.white,
      padding: const EdgeInsets.only(
        top: TSizes.sm,
        bottom: TSizes.sm,
        right: TSizes.sm,
        left: TSizes.md,
      ),
      child: Row(
        children: [
          Flexible(
            ///Text Field
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have coupon here, please enter it',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          ///Button
          SizedBox(width: 60,child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
            foregroundColor: dark ? Colors.white.withOpacity(0.5) : TColors.dark.withOpacity(0.5),
          ) ,child: const Text('Apply'))),
        ],
      ),
    );
  }
}