import 'package:fashion_star_shop/features/shop/models/Image.dart';
import 'package:fashion_star_shop/features/shop/models/option_value.dart';
import 'package:fashion_star_shop/features/shop/models/variant.dart';

class VariantDetail {
  List<Image> imageDTO;
  List<OptionValue> optionValueDTO;
  List<Variant> variantDTOList;

  VariantDetail(
      {required this.imageDTO,
      required this.optionValueDTO,
      required this.variantDTOList});

  factory VariantDetail.fromJson(Map<String, dynamic> json) {
    return VariantDetail(
      imageDTO:
          List<Image>.from(json['imageDTOS'].map((x) => Image.fromJson(x))),
      optionValueDTO: List<OptionValue>.from(json['variantDTOList']
              ['optionValueDTOList']
          .map((x) => OptionValue.fromJson(x))),
      variantDTOList: List<Variant>.from(
          json['variantDTOList'].map((x) => Variant.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageDTO': imageDTO.map((x) => x.toJson()).toList(),
      'optionValueDTO': optionValueDTO.map((x) => x.toJson()).toList(),
      'variantDTOList': variantDTOList.map((x) => x.toJson()).toList(),
    };
  }
}
