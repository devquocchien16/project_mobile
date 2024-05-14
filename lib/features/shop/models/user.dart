class User {
  final int? id;
  final String? clientName;
  final String? email;
  final String? phone;
  final bool? gender;
  final DateTime? birthday;

  User({
    this.id,
    required this.clientName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthday,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      clientName: json['clientName'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      birthday: DateTime.parse(json['birthday']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'birthday': birthday!.toIso8601String(),
    };
  }
}
