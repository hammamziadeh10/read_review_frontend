import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_build/Requests/user_requests.dart';

import '../Models/book.dart';
import '../constants.dart';

Future<dynamic> checkRefresh() async {
  final storage = FlutterSecureStorage();
  var accessToken = await storage.read(key: Constants.ACCESS_TOKEN);
  
  final response = await http
      .get(Uri.parse(API_URL + "book/1"), headers: {
    "Authorization": "Bearer " + accessToken!,
  });

  if (response.statusCode == 401 &&
      jsonDecode(response.body)["error"] == "token_expired") {
        await UserRequests().refreshToken();
      }
}
