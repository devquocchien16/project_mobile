class PaymentInfo {
  int id;
  int cartNumber;
  String nameOnCard;
  String expirationDate;

  PaymentInfo({
    required this.id,
    required this.cartNumber,
    required this.nameOnCard,
    required this.expirationDate,
  });

  // Factory constructor to create a PaymentInfo instance from a map
  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      id: json['id'],
      cartNumber: json['cartNumber'],
      nameOnCard: json['nameOnCard'],
      expirationDate: json['expirationDate'],
    );
  }

  // Method to convert PaymentInfo instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cartNumber': cartNumber,
      'nameOnCard': nameOnCard,
      'expirationDate': expirationDate,
    };
  }
}
