import 'package:fashion_star_shop/features/shop/models/variant.dart';

class CartLine {
  late int quantity;
  late Variant variantChosen;

  CartLine({required this.quantity, required this.variantChosen});

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'variantChosen': variantChosen.toJson(),
      };

  static CartLine fromJson(Map<String, dynamic> json) => CartLine(
        quantity: json['quantity'] ?? 0,
        variantChosen: Variant.fromJson(json['variantChosen']),
      );
}
