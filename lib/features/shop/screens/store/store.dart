import 'package:fashion_star_shop/common/widgets/brands/brand_show_case.dart';
import 'package:fashion_star_shop/features/shop/screens/brands/all_brands.dart';
import 'package:fashion_star_shop/features/shop/screens/store/widgets/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:fashion_star_shop/common/widgets/appbar/appbar.dart';
import 'package:fashion_star_shop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:fashion_star_shop/common/widgets/layouts/grid_layout.dart';
import 'package:fashion_star_shop/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:fashion_star_shop/common/widgets/texts/section_heading.dart';
import 'package:fashion_star_shop/utils/constants/colors.dart';
import 'package:fashion_star_shop/utils/constants/sizes.dart';
import 'package:fashion_star_shop/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_cards/brand_card.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium!,
          ),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
              iconColor: Colors.black12,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context) ? Colors.black : TColors.White,
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: Text(
                      'Store',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  background: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TSectionHeading(
                          title: "Featured Brands",
                          onPressed: () => Get.to(() => const AllBrandsScreen()),
                        ),
                        const TSearchContainer(
                          text: 'Search',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections /1.5),

                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                        TGridLayout(
                          itemCount: 4,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            return const TBrandCard(showBorder: false);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Furniture')),
                    Tab(child: Text('Devices')),
                    Tab(child: Text('Clothes')),
                    Tab(child: Text('Cosmetics')),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: List.generate(
              5, // Length of the TabBarView should match the length of tabs
                  (index) => SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      // Your content for each tab
                      TCategoryTab(), // For example, you can use TCategoryTab for each tab
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

