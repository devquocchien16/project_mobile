import 'dart:convert';
import 'package:fashion_star_shop/features/shop/models/Product.dart';
import 'package:http/http.dart' as http;

class HomeManagementApi {
  static const String baseUrl = 'http://10.0.2.2:5454/api';

  static Future<List<Product>> findAllProducts() async {
    Uri uri = Uri.parse('$baseUrl/products');
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List<dynamic> productsJson = json.decode(response.body);
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
