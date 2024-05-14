import 'dart:convert';
import 'package:fashion_star_shop/features/personalization/model/user.dart';
import 'package:fashion_star_shop/features/shop/models/findvariantrequest.dart';
import 'package:fashion_star_shop/features/shop/models/product_detail.dart';
import 'package:fashion_star_shop/features/shop/models/variant_detail.dart';
import 'package:http/http.dart' as http;

class CatManagementApi {
// Địa chỉ API
  static const String VARIANT_MANAGEMENT_API = "http://10.0.2.2:5454/api";

  static Future<ProductDetail?> findVariant(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('$VARIANT_MANAGEMENT_API/product-detail/$productId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        ProductDetail productDetail =
            ProductDetail.fromJson(json.decode(response.body));
        return productDetail;
      } else {
        throw Exception('Failed to load variant');
      }
    } catch (e) {
      print('Find variant API error: $e');
      return null;
    }
  }

  static Future<VariantDetail?> findVariantByProductId(
      int productId, FindVariantRequest request) async {
    var url = Uri.parse(
        '$VARIANT_MANAGEMENT_API/users/getUserByEmailCatLam?$productId'); // Change URL as needed
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return VariantDetail.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load variant');
      }
    } catch (e) {
      print('Caught error: $e');
      return null; // Or handle the exception as needed
    }
  }

  static Future<User?> findUserInfo(String email) async {
    var url = Uri.parse(
        '$VARIANT_MANAGEMENT_API/users/getUserByEmailCatLam?email=$email'); // Change URL as needed
    try {
      var response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return User.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load variant');
      }
    } catch (e) {
      print('Caught error: $e');
      return null; // Or handle the exception as needed
    }
  }

  static Future<Map<String, dynamic>?> findVariantById(int variantId) async {
    try {
      final response = await http.get(
        Uri.parse('$VARIANT_MANAGEMENT_API/variant/$variantId'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load variant by id');
      }
    } catch (e) {
      print('Find variant by id API error: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> updateVariantAfterCreate({
    required Map<String, dynamic> variant,
    required int variantId,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$VARIANT_MANAGEMENT_API/variant/update/$variantId'),
        body: json.encode(variant),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update variant');
      }
    } catch (e) {
      print('Update variant API error: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> createVariant({
    required Map<String, dynamic> variant,
    required int productId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$VARIANT_MANAGEMENT_API/variant/$productId/create'),
        body: json.encode(variant),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create variant');
      }
    } catch (e) {
      print('Create variant API error: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> deleteVariantAfterCreate({
    required String variantId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$VARIANT_MANAGEMENT_API/variant/delete/$variantId'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to delete variant');
      }
    } catch (e) {
      print('Delete variant API error: $e');
      return null;
    }
  }
}
