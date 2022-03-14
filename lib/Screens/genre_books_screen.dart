// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../widgets/back_button_custom.dart';
import 'package:test_build/Models/book.dart';
import 'package:test_build/Requests/book_requests.dart';
import 'package:test_build/Widgets/book_item.dart';

class GenreBooksScreen extends StatelessWidget {
  static const String routeName = "/genre_books_screen";

  late final Future<Books> futureBooks;
  late final String genreTitle;

  @override
  Widget build(BuildContext context) {
    loadData(context);
    futureBooks = BookRequests().fetchBooks(genreTitle);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: BackButtonCustom(context),
                margin: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
              ),
              FutureBuilder<Books>(
                future: futureBooks,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return buildBooksGridView(snapshot.data!.books);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildBooksGridView(List<Book> booksList) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 2.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: BookItem(booksList[index]),
          );
        },
        itemCount: booksList.length,
      ),
    );
  }

  void loadData(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    genreTitle = routeArgs['title']!;
  }
}
