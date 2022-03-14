import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/Models/book.dart';
import 'package:test_build/Providers/books_provider.dart';
import 'package:test_build/Requests/book_requests.dart';
import 'package:test_build/Requests/genre_requests.dart';
import 'package:test_build/Widgets/book_item.dart';
import 'package:test_build/Widgets/main_drawer.dart';
import '../Models/genre.dart';
import '../Widgets/genre_item.dart';

class GenresScreen extends StatefulWidget {
  static const routeName = "/genres_screen";

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  late MediaQueryData mediaQueryData;
  late Future<Genres> futureGenre;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late BooksProvider booksProvider;

  @override
  void initState() {
    super.initState();
    futureGenre = GenresRequests().fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    booksProvider = Provider.of<BooksProvider>(context, listen: true);

    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawer(),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: MediaQuery.of(context).viewPadding.top + 8),
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
            if (booksProvider.bookmarkedIDs.isNotEmpty)
              ...buildBookmarkedSection(),
            ...buildCategoriesSection(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildBookmarkedSection() {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.only(top: 20),
        child: buildTitleText("Bookmarked"),
      ),
      //place consumer here <- !!!
      buildBookmarkedListView(),
    ];
  }

  List<Widget> buildCategoriesSection() {
    return [
      GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: buildTitleText("Genres"),
        ),
      ),
      FutureBuilder<Genres>(
        future: futureGenre,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildGenresListView(snapshot.data!.genres);
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ];
  }

  Widget buildBookmarkedListView() {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemExtent: 160,
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: FutureBuilder<Book>(
              future:
                  BookRequests().fetchBook(booksProvider.bookmarkedIDs[index]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BookItem(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),

            //BookItem(booksProvider.bookmarked[index]),
          );
        },
        itemCount: booksProvider.bookmarkedIDs.length,
      ),
    );
  }

  Widget buildTitleText(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10, top: 0), //top: mediaQueryData.viewPadding.top + 38),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget buildGenresListView(genres) {
    return Expanded(
      // height: 700,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
          padding: EdgeInsets.only(
              top: 0,
              left: 0,
              right: 0,
              bottom: mediaQueryData.viewPadding.bottom + 10),
          itemBuilder: (ctx, index) {
            return GenreItem(genres[index]);
          },
          itemCount: genres.length,
        ),
      ),
    );
  }
}
