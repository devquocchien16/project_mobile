import 'dart:convert';
import 'package:http/http.dart' as http;

// Địa chỉ API
const String VARIANT_MANAGEMENT_API = "http://10.0.2.2:5454/api";

Future<Map<String, dynamic>?> findVariant(int productId) async {
  try {
    final response = await http.get(
      Uri.parse('$VARIANT_MANAGEMENT_API/product-detail/$productId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load variant');
    }
  } catch (e) {
    print('Find variant API error: $e');
    return null;
  }
}

Future<Map<String, dynamic>?> findVariantById(int variantId) async {
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

Future<Map<String, dynamic>?> updateVariantAfterCreate({
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

Future<Map<String, dynamic>?> createVariant({
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

Future<Map<String, dynamic>?> deleteVariantAfterCreate({
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
