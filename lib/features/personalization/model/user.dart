class User {
  final int? id;
  final String? clientName;
  final String? email;
  final String? phone;
  final bool? gender;
  final bool? enabled;

  User({
    this.id,
    required this.clientName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.enabled,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] ?? 0,
        clientName: json['clientName'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        gender: json['gender'] ?? '',
        enabled: json['enabled'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'enabled': enabled
    };
  }
}
