import 'package:flutter/material.dart';
import 'package:test_build/Screens/genre_books_screen.dart';
//import 'package:recipes_asignment/screens/category_meals_screen.dart';
import 'package:test_build/string_extension.dart';

import '../Models/genre.dart';

class GenreItem extends StatelessWidget {
  final Genre genre;

  GenreItem(this.genre);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      GenreBooksScreen.routeName,
      arguments: {
        "title" : genre.name,
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectCategory(context),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(239, 240, 249, 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 65,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Row(
          children: [
            buildImageContainer(genre.iconUrl),
            SizedBox(width: 30),
            Text(
              genre.name.capitalize(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        
      ),
    );
  }

  Widget buildImageContainer(String iconURL) {
    return Container(
      height: 45,
      width: 45,
      margin: const EdgeInsets.only(
        left: 24,
      ),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      //height: 40,
      child: Image.network(
        iconURL,
        fit: BoxFit.cover,
      ),
    );
  }
}
