import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/Providers/books_provider.dart';
import 'package:test_build/Screens/genre_books_screen.dart';
import 'package:test_build/Screens/genres_screen.dart';
import 'package:test_build/Screens/login_screen.dart';

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
     
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/": (ctx) => LoginScreen(),
          GenresScreen.routeName: (ctx) => GenresScreen(),
          GenreBooksScreen.routeName: (ctx) => GenreBooksScreen(),
        },
      ),
    );
  }
}