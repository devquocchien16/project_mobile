import 'package:http/http.dart' as http;

const String STORE_MANAGEMENT_API = "http://10.0.2.2:5454/api/stores";

Future<http.Response?> findStore(String storeId) async {
  try {
    final response = await http.get(Uri.parse('$STORE_MANAGEMENT_API/$storeId'));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load store');
    }
  } catch (e) {
    print("Find store API error: $e");
    return null;
  }
}