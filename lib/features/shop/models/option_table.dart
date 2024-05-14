import 'package:fashion_star_shop/features/shop/models/option_value.dart';
import 'package:flutter/foundation.dart';

class OptionTable {
  final int? id;
  late final String name;
  final List<OptionValue> optionValues;

  OptionTable({
    this.id,
    required this.name,
    required this.optionValues,
  });

  factory OptionTable.fromJson(Map<String, dynamic> json) {
    var optionValuesJson = json['optionValueDTOList'] as List<dynamic>? ?? [];
    return OptionTable(
      id: json['id'],
      name: json['name'],
      optionValues:
          optionValuesJson.map((e) => OptionValue.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'optionValues': optionValues.map((e) => e.toJson()).toList(),
    };
  }
}
