import 'package:fashion_star_shop/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
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
  String gender = '';
  String birthday = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    double? userId = prefs.getDouble('id');

    if (token != null && userId != null) {
      // Gọi API để lấy thông tin người dùng
      final response = await http.get(
        Uri.parse('${APIConstants.users}/$userId'),
        headers: {'Authorization': 'Bearer $token','Content-Type': 'application/json',},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);
        setState(() {
          clientName = userData['clientName'] ?? '';
          email = userData['email'] ?? '';
          phone = userData['phone'] ?? '';
          gender = userData['gender'] ?? '';
          birthday = userData['dob'] ?? '';
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
              content: Text('Failed to fetch user info. Please try again later.'),
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
    }
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
              Text('Gender: $gender'),
              Text('Date of Birth: $birthday'),
              // Thêm các thông tin khác của người dùng tại đây
            ],
          ),
        ),
      ),
    );
  }
}
