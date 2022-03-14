import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_build/constants.dart';
import '../Models/book.dart';
import 'check_refresh.dart';

class BookRequests {
  final storage = FlutterSecureStorage();

  Future<Books> fetchBooks([String? genreName]) async {
    await checkRefresh();

    var accessToken = await storage.read(key: Constants.ACCESS_TOKEN);

    final response = genreName == null ?
      await http
          .get(Uri.parse(API_URL + "books"), headers: {
            "Authorization" : "Bearer " + accessToken!,
          }) :
      await http
          .get(Uri.parse(API_URL + "books" + "?genre=" + genreName), headers: {
            "Authorization" : "Bearer " + accessToken!,
          });

    if (response.statusCode == 200) {
      return Books.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<Book> fetchBook(int bookID) async {
    await checkRefresh();
    var accessToken = await storage.read(key: Constants.ACCESS_TOKEN);

    final response = await http
        .get(Uri.parse(API_URL + "book/" + bookID.toString()), headers: {
          "Authorization" : "Bearer " + accessToken!,
        });

    if (response.statusCode == 200) {

      return Book.fromJson(jsonDecode(response.body));
    } else {

      throw Exception('Failed to load book');
    }
  }
}
