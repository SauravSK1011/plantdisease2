import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plantdisease/Views/AuthLogin.dart';
import 'package:plantdisease/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Future<bool?> presentloginornot() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? presentloginornotbool = prefs.getBool('login');

    return presentloginornotbool ?? false;
  }

  Future<bool> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool a = await prefs.remove('login');
    if (a) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
    return true;
  }

  Future<bool> login(Map<String, String> data) async {
    Dio dio = Dio();

    var url = '${Constants.url}/login';

    try {
      var response = await dio.post(
        url,
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool('login', true);

        var responseData = response.data;
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Failed to login. Status code: ${response.statusCode}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to login: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 8.0);
      print("Failed to login: $e");
      return false;
    }
  }

  Future<bool> signup(Map<String, String> data) async {
    Dio dio = Dio();

    var url = '${Constants.url}/register';

    try {
      var response = await dio.post(
        url,
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Failed to register. Status code: ${response.statusCode}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to register: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 8.0);
      print("Failed to login: $e");
      return false;
    }
  }
}
