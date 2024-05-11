

import 'package:fashion_star_shop/features/shop/models/option_value.dart';

class Product {
  final int id;
  final String title;
  final String mainPicture;
  final String description;
  List<OptionValue>? optionValues;

  Product({
    required this.id,
    required this.title,
    required this.mainPicture,
    required this.description,
    this.optionValues,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      mainPicture: json['mainPicture'],
      description: json['description'],
      optionValues: (json['OptionValue'] as List<dynamic>?)
          ?.map((e) => OptionValue.fromJson(e))
          .toList(),
    );
  }
}
