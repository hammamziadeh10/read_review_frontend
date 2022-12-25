import 'package:flutter/material.dart';
import 'package:test_build/Models/book.dart';
import 'package:test_build/Models/review.dart';
import 'package:test_build/Requests/book_requests.dart';
import 'package:test_build/Widgets/back_button_custom.dart';
import 'package:test_build/Widgets/review_item.dart';

class BookScreen extends StatefulWidget {
  static const routeName = "/book_screen";

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late MediaQueryData mediaQueryData;
  late Future<Book> futureBook;

  late final int bookId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData(context);
    futureBook = BookRequests().fetchBook(bookId);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
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
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: buildTitleText("Reviews"),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<Book>(
              future: futureBook,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildReviewsListView(snapshot.data!.reviews);
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReviewsListView(List<Review> reviews) {
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
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: ReviewItem(reviews[index]),
            );
          },
          itemCount: reviews.length,
        ),
      ),
    );
  }

  void loadData(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    bookId = routeArgs['book_id']!;
  }

  Widget buildTitleText(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontSize: 18,
      ),
    );
  }
}
