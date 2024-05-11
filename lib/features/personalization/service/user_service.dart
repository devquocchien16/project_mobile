import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:fashion_star_shop/features/personalization/model/user.dart';
import 'package:fashion_star_shop/services/api.dart';
import 'package:fashion_star_shop/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User> getUserById(int userId) async {
    final response = await http.get(Uri.parse('${APIConstants.baseUrl}/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
