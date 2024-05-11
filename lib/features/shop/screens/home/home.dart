import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:fashion_star_shop/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:fashion_star_shop/features/shop/screens/home/widgets/home_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion_star_shop/features/shop/models/Product.dart';
import 'package:fashion_star_shop/services/products_service.dart';
import 'package:fashion_star_shop/features/shop/screens/all_products/all_products.dart';
import 'package:fashion_star_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:fashion_star_shop/common/widgets/texts/section_heading.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/primary_header_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = HomeManagementApi.findAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // Phần header của bạn ở đây
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),
                  TSearchContainer(text: "search",),
                  SizedBox(height: TSizes.spaceBtwSections),
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(title: 'Categories', showActionButton: false,),
                        SizedBox(height: TSizes.spaceBtwItems,),
                        // THomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Phần slider và heading 'All products' của bạn ở đây
                  SizedBox(height: TSizes.spaceBtwSections),
                  FutureBuilder<List<Product>>(
                    future: futureProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width / 2, // 15 là tổng margin và spacing
                              child: TProductCardVertical(product: snapshot.data![index], productId: 0,),
                            );
                          },
                        );
                      } else {
                        return const Text('No products found');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
