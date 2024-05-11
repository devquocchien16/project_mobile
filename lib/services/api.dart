import 'package:dio/dio.dart';
import 'package:fashion_star_shop/utils/constants/api_constants.dart';
import 'package:fashion_star_shop/utils/constants/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api extends ChangeNotifier{
  Dio api = Dio();
  String? accessToken;

  late SharedPreferences prefs;

  Api(){
    api.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!options.path.contains('http')) {
          options.path = APIConstants.baseUrl + options.path;
        }
        prefs = await SharedPreferences.getInstance();
        accessToken = prefs.getString(StorageKey.token);

        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
    ));
  }

}