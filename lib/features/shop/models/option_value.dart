class OptionValue{
  final int id;
  final String value;

  OptionValue({required this.id,required this.value});

  factory OptionValue.fromJson(Map<String, dynamic> json) {
    return OptionValue(
      id: json['id'],
      value: json['value'],
    );
  }
}