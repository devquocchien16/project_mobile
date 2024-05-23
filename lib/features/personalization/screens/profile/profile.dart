import 'package:fashion_star_shop/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String clientName = '';
  String email = '';
  String phone = '';
  bool? gender;
  DateTime? birthday;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('token')) {
        String? token = prefs.getString('token');
        if (token != null) {
          print('Token in SharedPreferences: $token');
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          String? userId =
              decodedToken['sub']; // Lấy userId từ trường 'sub' trong token
          if (userId != null) {
            print('User ID: $userId');
            // Thực hiện các hành động khác nếu cần.
          } else {
            print('User ID is null in decoded token.');
          }
        } else {
          print('Token in SharedPreferences is null.');
        }
      } else {
        print('Token is not saved in SharedPreferences.');
        // Xử lý trường hợp không tìm thấy token ở đây.
      }
      // Gọi getUserInfo() sau khi kiểm tra SharedPreferences
      getUserInfo();
    });
  }

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      String? userId =
          decodedToken['sub']; // Lấy userId từ trường 'sub' trong token

      if (userId != null) {
        final response = await http.get(
          Uri.parse('${APIConstants.users}/$userId'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> userData = jsonDecode(response.body);
          setState(() {
            clientName = userData['clientName'] ?? 'N/A';
            email = userData['email'] ?? 'N/A';
            phone = userData['phone'] ?? 'N/A';
            gender = _parseGender(userData['gender']);
            birthday = _parseBirthday(userData['bỉ']);
          });
        } else {
          // Xử lý trường hợp lỗi khi gọi API
          print('Failed to fetch user info: ${response.statusCode}');
          // Hiển thị thông báo lỗi cho người dùng
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content:
                    Text('Failed to fetch user info. Please try again later.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        print('User ID is null in decoded token.');
      }
    } else {
      print('Token is null in SharedPreferences.');
      // Xử lý trường hợp không tìm thấy token ở đây.
    }
  }

  bool? _parseGender(String? gender) {
    if (gender == null) {
      return null;
    } else {
      return gender.toLowerCase() == 'male';
    }
  }

  DateTime? _parseBirthday(String? dob) {
    if (dob == null) return null;
    // Xử lý chuyển đổi chuỗi LocalDate thành DateTime
    return DateTime.parse(dob);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $clientName'),
              Text('Email: $email'),
              Text('Phone: $phone'),
              Text('Gender: ${_parseGender(gender as String?)}'),
              Text(
                  'Date of Birth: ${birthday != null ? _formatDate(birthday!) : 'N/A'}'),
              // Thêm các thông tin khác của người dùng tại đây
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
