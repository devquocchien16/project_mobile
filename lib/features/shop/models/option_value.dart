class OptionValue {
  final int? id;
  final String value;

  OptionValue({
    this.id,
    required this.value,
  });

  // Factory constructor for creating an instance from a JSON map
  factory OptionValue.fromJson(Map<String, dynamic> json) {
    return OptionValue(
      id: json['id'] ?? 0,
      value: json['value'] ?? '',
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}
