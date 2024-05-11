import 'dart:convert';
import 'package:fashion_star_shop/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class SignInService {
  Future<String> loginWebAccount(String email, String password) async {
    final url = Uri.parse('${APIConstants.baseUrl}/login'); // Change to your actual API URL
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return response.body; // Assuming the API directly returns the token
    } else {
      throw Exception('Failed to login. Status code: ${response.statusCode}');
    }
  }
}