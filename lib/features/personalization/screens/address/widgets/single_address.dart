import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.selectAddress});
  final bool selectAddress;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectAddress ? TColors.primary.withOpacity(0.5) : Colors.transparent,

      borderColor: selectAddress ? Colors.transparent : dark ? TColors.primary : Colors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(selectAddress ? Iconsax.tick_circle5 : null,
            color: selectAddress ? dark ? TColors.light : TColors.dark : null,),
          ),
          Column(
            children: [
              Text('275 Nguyen Van Dau, Binh Thanh, TP.HCM',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: TSizes.sm /2,),
              const Text("08121212",maxLines: 1, overflow: TextOverflow.ellipsis, ),
              const SizedBox(height: TSizes.sm/2,),
              const Text('275A Nguyen Van Dau, Binh Thanh, TP.HCM', softWrap: true,)
            ],
          )
        ],
      ),
    );
  }
}
