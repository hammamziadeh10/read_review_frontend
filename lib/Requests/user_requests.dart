import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_build/constants.dart';

class UserRequests {
  final storage = FlutterSecureStorage();

  Future<dynamic> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(API_URL + "login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      await storage.write(key: Constants.ACCESS_TOKEN, value: jsonDecode(response.body)["access_token"]);
      await storage.write(key: Constants.REFRESH_TOKEN , value: jsonDecode(response.body)["refresh_token"]);
      return {"access_token": jsonDecode(response.body)["access_token"]};
    } else if (response.statusCode == 401 &&
        jsonDecode(response.body)["message"] == "Invalid Credentials!") {
      throw Exception("Invalid Credentials");
    } else {
      print(jsonDecode(response.body)["error"]);
      throw Exception('Failed to login');
    }
  }

  Future<dynamic> refreshToken() async {
    var refreshToken = await storage.read(key: Constants.REFRESH_TOKEN);
    final response = await http.post(Uri.parse(API_URL + "refresh"), headers: {
      "Authorization": "Bearer " + refreshToken!,
    });

    if (response.statusCode == 200) {
      await storage.write(key: Constants.ACCESS_TOKEN, value: jsonDecode(response.body)["access_token"]);
      return jsonDecode(response.body)["access_token"];
    } else {
      throw Exception('Failed to refresh Token');
    }
  }
}
