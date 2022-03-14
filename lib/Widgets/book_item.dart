import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_build/Models/book.dart';
import 'package:test_build/Providers/books_provider.dart';
// import '../providers/meals_provider.dart';
// import '../screens/meal_screen.dart';

class BookItem extends StatelessWidget {
  final Book book;

  BookItem(
    this.book, {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context, listen: false);
    return GestureDetector(
      //onTap: () => selectMeal(context),
      child: Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.network(
              book.coverURL,
            ).image,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black.withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.86, -0.86),
              child: GestureDetector(
                onTap: () {
                  if (booksProvider.isBookmarked(book.id)) {
                    booksProvider.removeFromBookmarked(book.id);
                  } else {
                    booksProvider.addToBookmarked(book.id);
                  }
                },
                child: Consumer<BooksProvider>(
                  builder: (ctx, booksProvider, _) => Icon(
                    booksProvider.isBookmarked(book.id)
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // selectMeal(BuildContext ctx) {
  //   Navigator.of(ctx)
  //   .pushNamed(MealScreen.routeName, arguments: {"mealId": meal.id});
  // }
}
