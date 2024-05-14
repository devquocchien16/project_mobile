// ignore_for_file: null_check_always_fails

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:fashion_star_shop/common/widgets/appbar/appbar.dart';
import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fashion_star_shop/features/personalization/model/user.dart';
import 'package:fashion_star_shop/features/shop/models/cartLine.dart';
import 'package:fashion_star_shop/features/shop/models/review.dart';
import 'package:fashion_star_shop/features/shop/screens/cart/cart.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import '../../../../common/widgets/icon/circular_icon.dart';
import 'package:fashion_star_shop/common/widgets/images/images_rounded.dart';
import 'package:fashion_star_shop/common/widgets/texts/price_text.dart';
import 'package:fashion_star_shop/common/widgets/texts/product_title_text.dart';
import 'package:fashion_star_shop/features/shop/models/Product.dart';

import 'package:fashion_star_shop/features/shop/models/product_detail.dart';
import 'package:fashion_star_shop/features/shop/models/variant.dart';
import 'package:fashion_star_shop/features/shop/screens/product_detail/widgets/bottom_add_to_cart.dart';
import 'package:fashion_star_shop/features/shop/screens/product_reviews/product_review.dart';

import 'package:fashion_star_shop/services/variant_service.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart'; // Ensure this package is included
import 'package:iconsax/iconsax.dart';
import 'package:fashion_star_shop/common/widgets/texts/section_heading.dart';

import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetail? futureDetail;
  User? userLogin;
  List<String> variants = [];
  List<String> tables = [];
  Map<String, String?> selectedItems = {};
  Map<String, List<String>> tableData = {};
  List<Variant> variantObjects = []; // To store Variant objects
  List<double> variantPrices = []; // To store prices specifically
  Variant? variantShowed;
  Map<int?, String?> selectedVariant = {};
  String result = '';
  String data = '';
  String defaultData = '';
  int? number;
  String addToCartStatus = 'Chose this';
  bool checkStock = true;
  CartLine? cartLine;
  List<CartLine> cartLineList = [];
  Map<String, CartLine> cartLineMap = {};

  Future<void> saveCartLines(List<CartLine>? cartLines) async {
    final SharedPreferences catDetails = await SharedPreferences.getInstance();

    List<String> cartLinesString =
        cartLines!.map((cartLine) => jsonEncode(cartLine.toJson())).toList();
    await catDetails.setStringList('cartLinesData', cartLinesString);
    print(cartLinesString.toString());
  }

  Future<void> getCatVariant() async {
    final SharedPreferences catDetails = await SharedPreferences.getInstance();
    final int? cat = catDetails.getInt('catDetailsId');
    final String? userEmail = catDetails.getString('emailLogin');
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

    print('cartold${cartLineList.length}');
    print(userEmail);
    if (userEmail != null) {
      var details = await CatManagementApi.findUserInfo(userEmail);
      setState(() {
        userLogin = details;
      });
    }
    print(userLogin!.enabled);
    if (cat != null) {
      var detail = await CatManagementApi.findVariant(cat);
      setState(() {
        futureDetail = detail;
        tables.clear();
        tables.addAll(detail!.optionTableDTO.map((table) => table.name));
        print("Value Option: $tables");
        for (var item in tables) {
          var list =
              detail.optionTableDTO.where((element) => element.name == item);
          for (var e in list) {
            if (e.name == item) {
              List<String> newData = [];
              for (var a in e.optionValues) {
                newData.add(a.value);
              }
              tableData[item] = newData;
            }
          }
        }

        variants.clear();
        variantObjects.clear();
        variantPrices.clear();
        variantObjects.addAll(detail.variantDTOList);
        // print("Contents of variantObject: $variantObjects");

        variantPrices.addAll(detail.variantDTOList.map((v) => v.price));
        print("Contents of variant: $variantPrices");

        tableData.forEach((tableName, items) {
          selectedItems[tableName] = items.isNotEmpty ? items.first : null;
          defaultData += items.first;
        });

        print(defaultData);
        print(data);

        for (var item in futureDetail!.variantDTOList) {
          for (int i = 0; i < item.optionValueDTOList.length - 1; i++) {
            result = item.optionValueDTOList[i].value +
                item.optionValueDTOList[i + 1].value;
            selectedVariant[item.id] = result;
          }
        }
        print(selectedVariant);
        for (var item in selectedVariant.entries) {
          if (item.value!.contains(defaultData)) {
            List<Variant?> variantList = futureDetail!.variantDTOList.toList();
            variantShowed =
                variantList.firstWhere((element) => element!.id == item.key!);
            saveReviews(variantShowed?.reviewDTOList);
            if (variantShowed!.stockQuantity == 0) {
              checkStock = false;
            }
          }
        }
      });
    }
  }

  Future<void> saveReviews(List<Review>? reviewDataRaw) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString =
        json.encode(reviewDataRaw!.map((review) => review.toJson()).toList());
    await prefs.setString('reviewData', jsonString);
  }

  Future<void> getDefaultProduct() async {}
  @override
  void initState() {
    super.initState();
    getCatVariant();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
        decoration: BoxDecoration(
          color: darkMode ? TColors.darkerGrey : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusLg),
            topRight: Radius.circular(TSizes.cardRadiusLg),
          ),
        ),
        child: checkStock && number != null && number! > 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TCircularIcon(
                        icon: Icons.exposure_minus_1,
                        backgroundColor: TColors.darkGrey,
                        width: 40,
                        height: 40,
                        color: Colors.white,
                        onPressed: () async {
                          final SharedPreferences catDetails =
                              await SharedPreferences.getInstance();
                          final int? cat = catDetails.getInt('catDetailsId');
                          if (cat != null) {
                            var detail =
                                await CatManagementApi.findVariant(cat);
                            if (number != null && number != 0) {
                              setState(() {
                                futureDetail = detail;
                                for (var item in futureDetail!.variantDTOList) {
                                  for (int i = 0;
                                      i < item.optionValueDTOList.length - 1;
                                      i++) {
                                    result = item.optionValueDTOList[i].value +
                                        item.optionValueDTOList[i + 1].value;
                                    selectedVariant[item.id] = result;
                                  }
                                }
                                print(selectedVariant);
                                for (var item in selectedItems.entries) {
                                  data += item.value!;
                                }
                                for (var item in selectedVariant.entries) {
                                  if (item.value!.contains(data)) {
                                    List<Variant?> variantList =
                                        futureDetail!.variantDTOList.toList();
                                    variantShowed = variantList.firstWhere(
                                        (element) => element!.id == item.key!);
                                    saveReviews(variantShowed?.reviewDTOList);
                                    if (variantShowed!.stockQuantity <=
                                        number!) {
                                      Get.snackbar(
                                        "Warning",
                                        "Make sure your quantity is lower than product's stock",
                                      );
                                    } else {
                                      number = (number! - 1);
                                      if (number == 0) {
                                        addToCartStatus = 'Chose this';
                                      }
                                    }
                                    data = "";
                                    break;
                                  }
                                }
                              });
                            } else {
                              setState(() {
                                number = 0;
                                addToCartStatus = 'Chose this';
                              });
                            }
                          }
                        }, // Assuming 'iconSize' is a parameter for TCircularIcon
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Text(number != null ? number.toString() : '0',
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      TCircularIcon(
                        icon: Icons.plus_one,
                        backgroundColor: TColors.darkGrey,
                        width: 40,
                        height: 40,
                        color: Colors.white,
                        onPressed: () async {
                          final SharedPreferences catDetails =
                              await SharedPreferences.getInstance();
                          final int? cat = catDetails.getInt('catDetailsId');
                          if (cat != null) {
                            var detail =
                                await CatManagementApi.findVariant(cat);

                            if (number != null) {
                              setState(() {
                                futureDetail = detail;
                                for (var item in futureDetail!.variantDTOList) {
                                  for (int i = 0;
                                      i < item.optionValueDTOList.length - 1;
                                      i++) {
                                    result = item.optionValueDTOList[i].value +
                                        item.optionValueDTOList[i + 1].value;
                                    selectedVariant[item.id] = result;
                                  }
                                }
                                print(selectedVariant);
                                for (var item in selectedItems.entries) {
                                  data += item.value!;
                                }
                                for (var item in selectedVariant.entries) {
                                  if (item.value!.contains(data)) {
                                    List<Variant?> variantList =
                                        futureDetail!.variantDTOList.toList();
                                    variantShowed = variantList.firstWhere(
                                        (element) => element!.id == item.key!);
                                    saveReviews(variantShowed?.reviewDTOList);
                                    if (variantShowed!.stockQuantity <=
                                        number!) {
                                      Get.snackbar(
                                        "Warning",
                                        "Make sure your quantity is lower than product's stock",
                                      );
                                    } else {
                                      number = number! + 1;
                                    }
                                    data = "";
                                    break;
                                  }
                                }
                              });
                            } else {
                              setState(() {
                                number = 1;
                              });
                            }
                          }
                        },
                        // Assuming 'iconSize' is a parameter for TCircularIcon
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      SizedBox(
                        width: TSizes.spaceBtwItems * 4,
                        child: Text(
                            '\$${(variantShowed!.salePrice * (number ?? 0)).toStringAsFixed(2)}'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (userLogin != null && userLogin!.enabled!) {
                        cartLine = CartLine(
                            quantity: number!, variantChosen: variantShowed!);
                        cartLineList.add(cartLine!);
                        Get.snackbar(
                          "Success",
                          "Your product is in Cart now",
                        );
                      } else {
                        Get.snackbar(
                          "Warning",
                          "Make sure you are Logined and your account is enabled",
                        );
                      }
                      setState(() {
                        addToCartStatus = 'Chose this';
                        number = 0;
                        cartLine = null;
                      });
                      for (int i = 0; i < cartLineList.length - 1; i++) {
                        if (cartLineList[i].variantChosen.id ==
                            cartLineList[i + 1].variantChosen.id) {
                          cartLineList[i].quantity +=
                              cartLineList[i + 1].quantity;
                          cartLineList.removeAt(i + 1);
                          i--;
                        }
                      }

                      // In kết quả để kiểm tra
                      print(cartLineList.length);
                      if (cartLineList.isNotEmpty) {
                        saveCartLines(cartLineList);

                        for (var line in cartLineList) {
                          print(
                              'CartLine ID: ${line.variantChosen.name}, Quantity: ${line.quantity}');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(TSizes.md),
                      backgroundColor: Colors.green,
                      side: const BorderSide(color: Colors.green),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ],
              )
            : const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TAppBar(
              showBackArrow: true,
              actions: [
                TCircularIcon(
                  icon: Iconsax.heart5,
                  color: Colors.red,
                )
              ],
            ),
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                    child: Image(image: NetworkImage(variantShowed!.img))),
              ), // Padding
            ), // SizedBox

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: variantShowed!.imageDTOList!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (_, index) => TRoundedImage(
                    width: 80,
                    backgroundColor: darkMode ? TColors.dark : Colors.white,
                    border: Border.all(color: TColors.primary),
                    padding: const EdgeInsets.all(TSizes.sm),
                    imageUrl: variantShowed!.imageDTOList![index].imgPath,
                    onPressed: () {
                      setState(() {
                        print(variantShowed!.imageDTOList![index].imgPath);
                        variantShowed!.img =
                            variantShowed!.imageDTOList![index].imgPath;
                      });
                    },
                  ), // TRoundedImage
                ), // ListView.separated
              ), // SizedBox
            ),

            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Rating
                      Row(
                        children: [
                          const Icon(Iconsax.star5,
                              color: Colors.amber, size: 24),
                          const SizedBox(width: TSizes.spaceBtwItems / 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'bbbbb',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                const TextSpan(text: 'aaaaa'),
                              ],
                            ),
                          ), // Text.rich
                        ], // Row children
                      ), // Row

                      /// Share Button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share, size: TSizes.iconMd),
                      ), // IconButton
                    ], // Row mainAxisAlignment
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Price & Sale Price
                      Row(
                        children: [
                          /// Sale Tag
                          TRoundedContainer(
                            radius: TSizes.sm,
                            backgroundColor: TColors.secondary.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.sm, vertical: TSizes.xs),
                            child: Text(
                              '25%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(color: Colors.black),
                            ),
                          ), // TRoundedContainer
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Price
                          Text(
                            '\$${variantShowed!.price}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          TProductPriceText(
                              price: variantShowed!.salePrice.toString(),
                              isLarge: true),
                        ],
                      ), // Row
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),

                      TProductTitleText(title: variantShowed!.name),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                      Row(
                        children: [
                          TProductTitleText(
                              title: variantShowed!.stockQuantity > 0
                                  ? 'InStock'
                                  : 'OutStock'),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Text(variantShowed!.stockQuantity.toString(),
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ), // Row
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      /// Brand
                      // Row(
                      //   children: [
                      //     TCircularImage(
                      //       image: TImages.shoeIcon,
                      //       width: 32,
                      //       height: 32,
                      //       overlayColor:
                      //           darkMode ? Colors.white : Colors.black,
                      //     ), // TCircularImage
                      //     // const TBrandTitleWithVerifiedIcon(
                      //     //     title: 'Nike', brandTextSize: TextSizes.medium),
                      //   ],
                      // ), // Row
                    ],
                  ),
                  Column(
                    children: tables.map((tableName) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TSectionHeading(title: tableName),
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                          Wrap(
                            spacing: 8.0, // Horizontal space between chips
                            runSpacing: 4.0, // Vertical space between lines
                            children: _getChipsForTable(tableName),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const TSectionHeading(title: "Description"),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    variantShowed!.productDTO!.description.toString(),
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(
                          title:
                              'Reviews (${variantShowed!.reviewDTOList?.length})',
                          showActionButton: false),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () =>
                            Get.to(() => const ProductReviewsScreen()),
                      ),
                    ],
                  ),
                  if (checkStock)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: addToCartStatus == 'Chose this'
                            ? () {
                                if (number != null) {
                                  setState(() {
                                    number = number! + 1;
                                    addToCartStatus =
                                        'Waiting For Input Amount';
                                  });
                                } else {
                                  setState(() {
                                    number = 1;
                                    addToCartStatus =
                                        'Waiting For Input Amount';
                                  });
                                }
                              }
                            : null,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors
                                    .red; // Change color when button is disabled
                              }
                              return Theme.of(context)
                                  .primaryColor; // Use the default primary color
                            },
                          ),
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors
                                    .white; // Change text color when button is disabled
                              }
                              return Colors.white; // Default text color
                            },
                          ),
                        ),
                        child: Text(addToCartStatus),
                      ),
                    )
                  else
                    const SizedBox(height: TSizes.spaceBtwItems),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  if (cartLineList.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => CartScreen(cartLines: cartLineList));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            return Colors
                                .green; // Change color when button is disabled
                          }),
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors
                                  .white; // Change text color when button is disabled
                            },
                          ),
                        ),
                        child: const Text("Check your Cart"),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getChipsForTable(String tableName) {
    List<String> items = tableData[tableName] ?? [];
    return items
        .map((item) => ChoiceChip(
              label: Text(item),
              selected: selectedItems[tableName] == item,
              onSelected: (bool selected) {
                setState(() {
                  if (addToCartStatus != 'Waiting For Input Amount') {
                    if (selected) {
                      selectedItems[tableName] = item;
                    } else if (selectedItems[tableName] == item) {
                      selectedItems[tableName] = selectedItems[tableName] =
                          item; // Deselect if it was selected
                    }
                  } else {
                    Get.snackbar(
                      "Warning",
                      "Make sure your quantity is set by 0 to select another product",
                    );
                  }
                });
                print("$item selected: $selected");
                print(selectedItems);
                for (var item in selectedItems.entries) {
                  data += item.value!;
                }
                print(data);
                for (var item in selectedVariant.entries) {
                  if (item.value!.contains(data)) {
                    List<Variant?> variantList =
                        futureDetail!.variantDTOList.toList();
                    variantShowed = variantList
                        .firstWhere((element) => element!.id == item.key!);
                    saveReviews(variantShowed?.reviewDTOList);
                    if (variantShowed!.stockQuantity == 0) {
                      checkStock = false;
                    }
                    data = "";
                    break;
                  }
                }
              },
            ))
        .toList();
  }
}
