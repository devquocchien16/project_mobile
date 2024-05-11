import 'package:fashion_star_shop/common/widgets/images/circular_image.dart';
import 'package:fashion_star_shop/features/personalization/screens/profile/profile.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0),
      title: Text(
        'Coding with T',
        style: ThemeData.dark().textTheme.headlineSmall!.copyWith(color: Colors.white),
      ),
      subtitle: Text(
        'support@codingwithT.com',
        style: ThemeData.dark().textTheme.bodyMedium!.copyWith(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(Iconsax.edit, color: Colors.white),
      ),
    );
  }
}