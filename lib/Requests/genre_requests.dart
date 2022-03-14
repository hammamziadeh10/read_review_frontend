import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_build/constants.dart';
import '../Models/genre.dart';
import 'check_refresh.dart';

class GenresRequests {
  final storage = FlutterSecureStorage();
  
  Future<Genres> fetchGenres() async {
    await checkRefresh();
    var accessToken = await storage.read(key: Constants.ACCESS_TOKEN);
    final response = await http.get(Uri.parse(API_URL + "genres"), headers: {
      "Authorization": "Bearer " + accessToken!,
    });

    if (response.statusCode == 200) {
      return Genres.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<Genre> fetchGenre(String genreName) async {
    await checkRefresh();
    var accessToken = await storage.read(key: Constants.ACCESS_TOKEN);

    final response =
        await http.get(Uri.parse(API_URL + "genre/" + genreName), headers: {
      "Authorization": "Bearer " + accessToken!,
    });

    if (response.statusCode == 200) {
      return Genre.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);

      throw Exception('Failed to load genres');
    }
  }
}
