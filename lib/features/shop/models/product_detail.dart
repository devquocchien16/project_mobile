import 'package:fashion_star_shop/features/shop/models/Product.dart';
import 'package:fashion_star_shop/features/shop/models/option_table.dart'; // Continue using Product from here if needed
import 'package:fashion_star_shop/features/shop/models/option_value.dart';
import 'package:fashion_star_shop/features/shop/models/variant.dart';

class ProductDetail {
  late Product productDTO;
  late int ratings;
  late double star;
  late List<OptionValue> optionValueDTO;
  late List<OptionTable> optionTableDTO;
  final List<Variant> variantDTOList;
  // final List<ProductAttributeDTO> productAttributeDTOList;
  // final List<ReviewDTO> reviewDTOList;
  // final StoreDTO storeDto;

  ProductDetail({
    required this.productDTO,
    required this.ratings,
    required this.star,
    // required this.optionValueDTO,
    required this.optionTableDTO,
    required this.variantDTOList,
    // required this.productAttributeDTOList,
    // required this.variantDto,
    // required this.reviewDTOList,
    // required this.storeDto,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      productDTO: Product.fromJson(json['productDTO']),
      ratings: json['ratings'],
      star: json['star'],
      // optionValueDTO: List<OptionValue>.from(
      //     json['optionTableDto'].map((x) => OptionValue.fromJson(x))),
      optionTableDTO: List<OptionTable>.from(
          json['optionTableDto'].map((x) => OptionTable.fromJson(x))),
      variantDTOList: List<Variant>.from(
          json['variantDTOList'].map((x) => Variant.fromJson(x))),
      // storeDto: StoreDTO.fromJson(json['storeDto']),
      // productAttributeDTOList: List<ProductAttributeDTO>.from(json['productAttributeDTOList'].map((x) => ProductAttributeDTO.fromJson(x))),
      // variantDto: VariantDTO.fromJson(json['variantDto']),
      // reviewDTOList: List<ReviewDTO>.from(json['reviewDTOList'].map((x) => ReviewDTO.fromJson(x))),
    );
  }
}
