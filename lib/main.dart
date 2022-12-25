import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:test_build/Providers/books_provider.dart';
import 'package:test_build/Screens/book_screen.dart';
import 'package:test_build/Screens/genre_books_screen.dart';
import 'package:test_build/Screens/genres_screen.dart';
import 'package:test_build/Screens/login_screen.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BooksProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        
        theme: ThemeData(
          //colorScheme: ColorScheme.light(),
          primarySwatch: Colors.blue,
          
        ),
        initialRoute: "/",
        routes: {
          "/": (ctx) => LoginScreen(),
          GenresScreen.routeName: (ctx) => GenresScreen(),
          GenreBooksScreen.routeName: (ctx) => GenreBooksScreen(),
          BookScreen.routeName: (ctx) => BookScreen(),
        },
      ),
    );
  }

  Future<bool> checkIfLoggedIn() async {
    final storage = FlutterSecureStorage();
    var accessToken = await storage.read(key: Constants.ACCESS_TOKEN);
    if (accessToken == null) {
      //goToGenresPage(context);
      return false;
    }else{
      return true;
    }
  }
}