import 'dart:convert';

import 'package:fashion_star_shop/features/shop/models/cartLine.dart';
import 'package:fashion_star_shop/features/shop/screens/cart/cart.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TCartCounterIcon extends StatefulWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
  });

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  State<TCartCounterIcon> createState() => _TCartCounterIconState();
}

class _TCartCounterIconState extends State<TCartCounterIcon> {
  List<CartLine> cartLineList = [];
  Future<void> getCartList() async {
    final SharedPreferences catDetails = await SharedPreferences.getInstance();

    late List<String> cartLinesString =
        catDetails.getStringList('cartLinesData') ?? [];
    if (cartLinesString.isNotEmpty) {
      setState(() {
        cartLineList = cartLinesString
            .map((cartLineString) =>
                CartLine.fromJson(jsonDecode(cartLineString)))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => CartScreen(
                cartLines: cartLineList,
              )),
          icon: Icon(Icons.shopping_bag, color: widget.iconColor),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                cartLineList.length.toString(),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.White, fontSizeFactor: 0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
