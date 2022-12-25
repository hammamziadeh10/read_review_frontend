import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:test_build/Providers/books_provider.dart';
import 'package:test_build/Screens/book_screen.dart';
import 'package:test_build/Screens/genre_books_screen.dart';
import 'package:test_build/Screens/genres_screen.dart';
import 'package:test_build/Screens/login_screen.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final loggedIn = await checkIfLoggedIn();
  runApp(MyApp(loggedIn));
}

Future<bool> checkIfLoggedIn() async {
  final storage = FlutterSecureStorage();
  var accessToken = await storage.read(key: Constants.ACCESS_TOKEN);
  print(accessToken);
  return accessToken != null;
}

class MyApp extends StatelessWidget {
  var loggedIn = false;

  MyApp(this.loggedIn);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BooksProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: loggedIn ? GenresScreen.routeName : "/",
        routes: {
          "/": (ctx) => LoginScreen(),
          GenresScreen.routeName: (ctx) => GenresScreen(),
          GenreBooksScreen.routeName: (ctx) => GenreBooksScreen(),
          BookScreen.routeName: (ctx) => BookScreen(),
        },
      ),
    );
  }
}
