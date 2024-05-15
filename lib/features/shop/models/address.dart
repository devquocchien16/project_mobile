class Address {
  int id;
  String district;
  String ward;
  String city;
  String street;
  Address({
    required this.id,
    required this.district,
    required this.ward,
    required this.city,
    required this.street,
  });

  // Factory constructor to create an Address instance from a map (JSON)
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      district: json['district'],
      ward: json['ward'],
      city: json['city'],
      street: json['street'],
    );
  }
}
