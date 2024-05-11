import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this. border,
    this. padding,
    this . onPressed,
    this.width = 900,
    this. height = 900,
    this. applyImageRadius = false,
    required this. imageUrl,
    this. fit = BoxFit.contain,
    this. backgroundColor = TColors. light,
    this.borderRadius = TSizes.md,
    this.isNetworkImage = false
  });
  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration:  BoxDecoration(
          border: border,
          color: backgroundColor, borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
          child: true ? Image.network(imageUrl, fit: fit) : Image.asset(imageUrl, fit: fit),
        ),

      ),
    );
  }
}