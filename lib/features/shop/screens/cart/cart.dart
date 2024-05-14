import 'dart:convert';
import 'package:fashion_star_shop/features/shop/models/cartLine.dart';
import 'package:fashion_star_shop/features/shop/models/product_detail.dart';
import 'package:fashion_star_shop/features/shop/models/variant.dart';
import 'package:fashion_star_shop/features/shop/screens/product_detail/product_detail.dart';
import 'package:fashion_star_shop/services/variant_service.dart';
import 'package:get/get.dart';
import 'package:fashion_star_shop/features/shop/screens/checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  final List<CartLine> cartLines;
  const CartScreen({Key? key, required this.cartLines}) : super(key: key);
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ProductDetail? futureDetail;
  String result = '';
  Map<int?, String?> selectedVariant = {};
  Map<String, String?> selectedItems = {};
  String data = '';
  Variant? variantShowed;

  Future<void> saveCartLines(List<CartLine>? cartLines) async {
    final SharedPreferences catDetails = await SharedPreferences.getInstance();
    List<String> cartLinesString =
        cartLines!.map((cartLine) => jsonEncode(cartLine.toJson())).toList();
    await catDetails.setStringList('cartLinesData', cartLinesString);
    print(cartLinesString.toString());
  }

  Future<void> incrementQuantity(int index) async {
    final SharedPreferences catDetails = await SharedPreferences.getInstance();
    final int? cat = catDetails.getInt('catDetailsId');
    if (cat != null) {
      var detail = await CatManagementApi.findVariant(cat);
      setState(() {
        futureDetail = detail;
        for (var item in futureDetail!.variantDTOList) {
          for (int i = 0; i < item.optionValueDTOList.length - 1; i++) {
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
            List<Variant?> variantList = futureDetail!.variantDTOList.toList();
            variantShowed =
                variantList.firstWhere((element) => element!.id == item.key!);

            if (variantShowed!.stockQuantity <=
                widget.cartLines[index].quantity) {
              Get.snackbar(
                "Warning",
                "Make sure your quantity is lower than product's stock",
              );
            } else {
              widget.cartLines[index].quantity++;
              saveCartLines(widget.cartLines);
            }
            data = "";
            break;
          }
        }
      });
    }
  }

  Future<void> decrementQuantity(int index) async {
    final SharedPreferences catDetails = await SharedPreferences.getInstance();
    final int? cat = catDetails.getInt('catDetailsId');
    if (cat != null) {
      var detail = await CatManagementApi.findVariant(cat);
      if (widget.cartLines[index].quantity > 1) {
        setState(() {
          futureDetail = detail;
          for (var item in futureDetail!.variantDTOList) {
            for (int i = 0; i < item.optionValueDTOList.length - 1; i++) {
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
              variantShowed =
                  variantList.firstWhere((element) => element!.id == item.key!);

              if (variantShowed!.stockQuantity <=
                  widget.cartLines[index].quantity) {
                Get.snackbar(
                  "Warning",
                  "Make sure your quantity is lower than product's stock",
                );
              } else {
                widget.cartLines[index].quantity--;
                saveCartLines(widget.cartLines);
              }
              data = "";
              break;
            }
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        leading: BackButton(
          onPressed: () {
            Get.to(() => const ProductDetailScreen());
          },
        ),
      ),
      body: widget.cartLines.isEmpty
          ? const Center(
              child: Text('No items in the cart.'),
            )
          : ListView.builder(
              itemCount: widget.cartLines.length,
              itemBuilder: (context, index) {
                final cartLine = widget.cartLines[index];
                return ListTile(
                  leading: CircleAvatar(
                    // Just an example, replace with your image widget
                    backgroundImage: NetworkImage(cartLine.variantChosen.img),
                  ),
                  title: Text(cartLine.variantChosen.name),
                  subtitle: Text(
                      'Quantity: ${cartLine.quantity}\nPrice: \$${(cartLine.quantity * cartLine.variantChosen.salePrice).toStringAsFixed(2)}'),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.remove_circle_outline),
                  //   onPressed: () => setState(() {
                  //     widget.cartLines.removeAt(index);
                  //     saveCartLines(widget.cartLines);
                  //   }),
                  // ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => decrementQuantity(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => incrementQuantity(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_forever),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Need To Confirm'),
                                content: const Text(
                                    'Are you sure you want to remove this item from your cart?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Đóng hộp thoại mà không làm gì cả
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.cartLines.removeAt(index);
                                        saveCartLines(widget
                                            .cartLines); // Cập nhật SharedPreferences
                                      });
                                      Navigator.of(context)
                                          .pop(); // Đóng hộp thoại sau khi xóa
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckoutScreen()),
              ),
              child: const Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
