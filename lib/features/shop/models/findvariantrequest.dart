class FindVariantRequest {
  List<int> optionValueIds;

  FindVariantRequest({required this.optionValueIds});

  Map<String, dynamic> toJson() {
    return {
      'optionValueIds': optionValueIds,
    };
  }
}