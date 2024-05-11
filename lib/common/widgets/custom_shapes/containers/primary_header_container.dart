import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:fashion_star_shop/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: SizedBox(
        height: 400,
        child: Container(
          color: TColors.primary,
          /// -- [size.isFinite': is not true] Error -> Read README.md file at [DESIGN ERRORS] # 1
          child: Stack(
            children: [
              /// -- Background Custom Shapes
              Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1)),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1)),
              ),
              child,
            ],
          ), // Stack
        ), // Container
      ), // SizedBox
    ); // TCurvedEdgesWidget
  }
}
