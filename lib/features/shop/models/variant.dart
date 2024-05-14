import 'package:fashion_star_shop/features/shop/models/Image.dart';
import 'package:fashion_star_shop/features/shop/models/Product.dart';
import 'package:fashion_star_shop/features/shop/models/option_value.dart';
import 'package:fashion_star_shop/features/shop/models/review.dart';

class Variant {
  late final int? id;
  final String? skuCode;
  final int stockQuantity;
  final double weight;
  final String name;
  final double price;
  final double salePrice;
  late String img;
  // final bool? isDeleted;
  final Product? productDTO;
  final List<OptionValue> optionValueDTOList;
  final List<Image>? imageDTOList;
  final List<Review>? reviewDTOList;

  Variant({
    this.id,
    this.skuCode,
    required this.stockQuantity,
    required this.weight,
    required this.name,
    required this.price,
    required this.salePrice,
    required this.img,
    // this.isDeleted,
    this.productDTO,
    required this.optionValueDTOList,
    required this.imageDTOList,
    required this.reviewDTOList,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      skuCode: json['skuCode'] ?? '',
      stockQuantity: json['stockQuantity'],
      weight: json['weight'],
      name: json['name'] ?? '',
      price: json['price'],
      salePrice: json['salePrice'],
      img: json['img'],
      // isDeleted: json['isDeleted'] ?? '',
      productDTO: json['productDTO'] != null
          ? Product.fromJson(json['productDTO'])
          : null,
      optionValueDTOList: (json['optionValueDTOList'] as List)
          .map((e) => OptionValue.fromJson(e))
          .toList(),
      imageDTOList: json['imageDTOList'] != null
          ? (json['imageDTOList'] as List)
              .map((e) => Image.fromJson(e))
              .toList()
          : null,
      reviewDTOList: (json['reviewDTOList'] as List)
          .map((e) => Review.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'skuCode': skuCode,
      'stockQuantity': stockQuantity,
      'weight': weight,
      'name': name,
      'price': price,
      'salePrice': salePrice,
      'img': img,
      // 'isDeleted': isDeleted,
      'productDTO': productDTO?.toJson(),
      'optionValueDTOList': optionValueDTOList.map((e) => e.toJson()).toList(),
      'imageDTOList': imageDTOList?.map((e) => e.toJson()).toList(),
      'reviewDTOList': reviewDTOList!.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Variant(id: $id, skuCode: $skuCode, stockQuantity: $stockQuantity, weight: $weight, name: $name, price: $price, salePrice: $salePrice, img: $img)';
  }
}
