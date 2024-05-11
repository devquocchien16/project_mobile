import 'package:fashion_star_shop/features/shop/models/Image.dart';
import 'package:fashion_star_shop/features/shop/models/Product.dart';

class Variant {
  final int id;
  final String skuCode;
  final int stockQuantity;
  final double weight;
  final String name;
  final double price;
  final double salePrice;
  final String img;
  final Product productDTO;
  final List<ImageDTO> imageDTOList;

  Variant( {
    required this.id,
    required this.skuCode,
    required this.stockQuantity,
    required this.weight,
    required this.name,
    required this.price,
    required this.salePrice,
    required this.img,
    required this.imageDTOList,
    required this.productDTO,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    List<ImageDTO> imageDTOList = [];
    if (json['imageDTOList'] != null) {
      imageDTOList = (json['imageDTOList'] as List)
          .map((e) => ImageDTO.fromJson(e))
          .toList();
    }
    return Variant(
      productDTO: Product.fromJson(json['productDTO']),
      id: json['id'],
      skuCode: json['skuCode'],
      stockQuantity: json['stockQuantity'],
      weight: json['weight'],
      name: json['name'],
      price: json['price'],
      salePrice: json['salePrice'],
      img: json['img'],
      imageDTOList: imageDTOList,
    );
  }
}
