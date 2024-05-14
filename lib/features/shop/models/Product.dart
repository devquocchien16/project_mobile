import 'package:fashion_star_shop/features/shop/models/option_value.dart';

class Product {
  final int id;
  final String title;
  final String mainPicture;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.mainPicture,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      mainPicture: json['mainPicture'],
      description: json['description'],
      // optionValues: (json['OptionValue'] as List<dynamic>?)
      //     ?.map((e) => OptionValue.fromJson(e))
      //     .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'mainPicture': mainPicture,
      // 'imageList': imageList.map((e) => e.toJson()).toList(),
      // 'status': status,
      // 'createAt': createAt.toIso8601String(),
      // 'updatedAt': updatedAt.toIso8601String(),
      // 'store': store?.toJson(),
      // 'storeCategoryId': storeCategoryId,
    };
  }
}
