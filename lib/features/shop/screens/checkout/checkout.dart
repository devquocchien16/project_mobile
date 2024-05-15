import 'dart:convert';

import 'package:fashion_star_shop/common/widgets/texts/section_heading.dart';
import 'package:fashion_star_shop/features/authentication/screens/signup.widgets/success_screen.dart';
import 'package:fashion_star_shop/features/personalization/model/user.dart';
import 'package:fashion_star_shop/features/shop/models/Payments.dart';
import 'package:fashion_star_shop/features/shop/models/address.dart';
import 'package:fashion_star_shop/features/shop/models/cartLine.dart';
import 'package:fashion_star_shop/naviagation_menu.dart';
import 'package:fashion_star_shop/services/variant_service.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:fashion_star_shop/common/widgets/appbar/appbar.dart';
import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fashion_star_shop/features/shop/screens/checkout/widgets/billing_address.dart';

import 'package:fashion_star_shop/features/shop/screens/checkout/widgets/billing_sections.dart';

import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  final List<CartLine> cartLines;
  const CheckoutScreen({Key? key, required this.cartLines}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  User? userLogin;
  List<PaymentInfo> listPayment = [];
  List<Address> listAddress = [];
  PaymentInfo? paymentInfoStripe;
  String? paymentStatus;

  Future<void> saveCartLines(List<CartLine>? cartLines) async {
    final SharedPreferences catDetails = await SharedPreferences.getInstance();
    List<String> cartLinesString =
        cartLines!.map((cartLine) => jsonEncode(cartLine.toJson())).toList();
    await catDetails.setStringList('cartLinesData', cartLinesString);
    print(cartLinesString.toString());
  }

  Future<void> getUser() async {
    final SharedPreferences catDetails = await SharedPreferences.getInstance();

    final String? userEmail = catDetails.getString('emailLogin');
    var resultPayment = await CatManagementApi.findPaymentList();
    if (userEmail != null) {
      var details = await CatManagementApi.findUserInfo(userEmail);

      var resultAddress =
          await CatManagementApi.findAddressList(details!.id.toString());

      setState(() {
        userLogin = details;
        listPayment = resultPayment ?? [];
        listAddress = resultAddress ?? [];
        paymentInfoStripe = listPayment
            .where((element) => element.nameOnCard.contains('StripePayment'))
            .first;

        print('sdfdsf${listAddress.length}');
        print('sdfdsf${listPayment.length}');
        print('sdfdsf${paymentInfoStripe!.nameOnCard}');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var cartLine in widget.cartLines) {
      totalPrice += cartLine.quantity * cartLine.variantChosen.salePrice;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Order Review',
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.cartLines.length,
                itemBuilder: (context, index) {
                  final cartLine = widget.cartLines[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(cartLine.variantChosen.img),
                    ),
                    title: Text(cartLine.variantChosen.name),
                    subtitle: Text(
                        'Quantity: ${cartLine.quantity}\nPrice: \$${(cartLine.quantity * cartLine.variantChosen.salePrice).toStringAsFixed(2)}'),
                  );
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? Colors.black : Colors.white,
                child: Column(
                  children: [
                    Column(
                      children: [
                        /// SubTotal
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '\$${calculateTotalPrice().toString()}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),

                        /// Shipping Fee
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '\$8.0',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Total',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '\$${(calculateTotalPrice() + 8).toString()}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(),
                    Column(
                      children: [
                        TSectionHeading(
                          title: 'Payment Information',
                          buttonTitle: paymentStatus ?? 'Add Info',
                          onPressed: () {
                            TextEditingController cardNameController =
                                TextEditingController();
                            TextEditingController cardNumberController =
                                TextEditingController();
                            TextEditingController expirationDateController =
                                TextEditingController();
                            GlobalKey<FormState> _formKey = GlobalKey<
                                FormState>(); // Form key for validation

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      const Text("Add Your Visa/Master Card"),
                                  content: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        minWidth: 300, minHeight: 300),
                                    child: Form(
                                      key:
                                          _formKey, // Assign the GlobalKey to the Form
                                      child: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: TextFormField(
                                                controller: cardNameController,
                                                decoration: const InputDecoration(
                                                    labelText: "Name on Card",
                                                    hintText:
                                                        "Enter cardholder's name",
                                                    border:
                                                        OutlineInputBorder(),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10)),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter the name on card';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: TextFormField(
                                                controller:
                                                    cardNumberController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            "Card Number",
                                                        hintText:
                                                            "Enter card number",
                                                        border:
                                                            OutlineInputBorder(),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10)),
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter a card number';
                                                  }
                                                  if (value.length < 16) {
                                                    return 'Card number must be at least 16 digits';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: TextFormField(
                                                controller:
                                                    expirationDateController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            "Expiration Date",
                                                        hintText: "MM/YY",
                                                        border:
                                                            OutlineInputBorder(),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10)),
                                                keyboardType:
                                                    TextInputType.datetime,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter the expiration date';
                                                  }
                                                  // Additional validation can be added for date format or validity
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                      child: const Text("Save"),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Only save if all fields pass validation
                                          // String cardName =
                                          //     cardNameController.text;
                                          // String cardNumber =
                                          //     cardNumberController.text;
                                          // String expirationDate =
                                          //     expirationDateController.text;
                                          // processPaymentMethodUpdate(cardName, cardNumber, expirationDate);
                                          setState(() {
                                            paymentStatus = 'OK';
                                          });
                                          Navigator.of(context)
                                              .pop(); // Close the dialog after saving
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        Row(
                          children: [
                            TRoundedContainer(
                              width: 250,
                              height: 150,
                              backgroundColor:
                                  dark ? TColors.light : Colors.white,
                              padding: const EdgeInsets.all(TSizes.sm),
                              child: const Image(
                                image: AssetImage(TImages.stripe),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(),
                    AddressSelection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: listAddress.isNotEmpty && paymentStatus == 'OK'
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  side: const BorderSide(
                      color: Colors.green,
                      width: 2.0), // Border color and width
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8)), // Optional: Rounded corners// Set the background color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20), // Set the padding for larger size
                  textStyle: const TextStyle(
                      fontSize: 16), // You can also adjust the font size here
                ),
                onPressed: () async {
                  if (await CatManagementApi.saveOrder(
                      userLogin!.id.toString(),
                      DateTime.now().toString(),
                      listAddress.first.id.toString(),
                      (calculateTotalPrice() + 8.toDouble()).toString(),
                      paymentInfoStripe!.id.toString(),
                      widget.cartLines)) {
                    saveCartLines([]);
                    Get.to(() => SuccessScreen(
                        image: TImages.paymentSuccess,
                        title: "Payment Success",
                        subTitle: 'Completed Payment',
                        onPressed: () {
                          Get.to(() => const NavigationMenu());
                        }));
                  } else {
                    print('not ok');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Network Error'),
                          content: const Text('Check your network!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Đóng hộp thoại mà không làm gì cả
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                    'Check-out \$${(calculateTotalPrice() + 8).toString()}'),
              )
            : const SizedBox(height: TSizes.spaceBtwItems),
      ),
    );
  }
}
