import 'package:fashion_star_shop/features/personalization/model/user.dart';
import 'package:fashion_star_shop/features/shop/models/option_value.dart';

class Review {
  final int? id;
  final int? star;
  final String? title;
  final String? content;
  final bool? verifiedAdmin;
  final int? updatedAt;
  final User? userDTO;

  Review({
    this.id,
    required this.star,
    required this.title,
    required this.content,
    required this.verifiedAdmin,
    required this.updatedAt,
    required this.userDTO,
  });

  // Optionally, you might want to add a factory method to create a Review from a map
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      star: json['star'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      verifiedAdmin: json['verified_admin'],
      updatedAt: json['update_at'] ?? 0,
      userDTO: User.fromJson(json['userDto']),
    );
  }

  // Method to convert Review to a map, useful for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'star': star,
      'title': title,
      'content': content,
      'verified_admin': verifiedAdmin,
      'update_at': updatedAt,
      'userDto': userDTO!.toJson(),
    };
  }
}

// Define the User and OptionValue classes similarly if not already defined
