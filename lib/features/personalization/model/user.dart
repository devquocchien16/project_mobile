class User {
  final int id;
  final String clientName;
  final String email;
  final String phone;
  final String gender;
  final String birthDay;

  User({
    required this.id,
    required this.clientName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthDay,
  });

  factory User.fromJson(Map<String, dynamic> json) {

    return User(
      id: json['id'],
      clientName: json['clientName'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      birthDay: json['birthDay'],
    );
  }
}
