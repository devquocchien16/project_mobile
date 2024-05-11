import 'package:fashion_star_shop/common/widgets/texts/brand_title_text.dart';
import 'package:fashion_star_shop/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart'; // Assuming TBrandTitleText is imported from this file

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    Key? key,
    this.textColor,
    this.maxLines = 1,
    required this.title,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  }) : super(key: key);

  final Color? textColor;
  final String title;
  final int maxLines;
  final Color iconColor;
  final TextAlign textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: TSizes.xs),
        Icon(Icons.verified, color: iconColor, size: TSizes.iconXs),
      ],
    );
  }
}
