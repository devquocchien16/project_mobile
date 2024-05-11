import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TLocalStorage {
  static final TLocalStorage _instance = TLocalStorage._internal();

  factory TLocalStorage() {
    return _instance;
  }
  TLocalStorage._internal();
  final _storage = GetStorage();

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
    }
  
  T? readData<T>(String key) {
      return _storage.read<T>(key);
  }
  
  Future<void> removeData(String key) async {
    await _storage.remove (key) ;
  }
  Future<void> clearAll() async {
      await _storage. erase ();
  }
  Future<Map<String, dynamic>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? ''; // Lấy token từ SharedPreferences, mặc định là chuỗi trống nếu không tìm thấy
    int userID = prefs.getInt('userID') ?? 0; // Lấy userID từ SharedPreferences, mặc định là 0 nếu không tìm thấy
    return {'token': token, 'userID': userID}; // Trả về một Map chứa token và userID
  }

// Sử dụng hàm để lấy token và userID và gọi API
  void fetchUserInfo() async {
    Map<String, dynamic> userInfo = await getUserInfo();
    String token = userInfo['token'];
    int userID = userInfo['userID'];
    // Gọi API với token và userID
  }
}
