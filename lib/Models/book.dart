import 'package:test_build/Models/review.dart';

class Book {
  int id;
  String name;
  String coverURL;
  String authorName;
  String genre;
  List<Review> reviews;

  Book(
    this.id,
    this.name,
    this.coverURL,
    this.authorName,
    this.genre,
    this.reviews,
  );

  factory Book.fromJson(Map<String, dynamic> json) {
    Reviews reviewsObject = Reviews.fromJson(json["reviews"]);
    return Book(
      json["id"],
      json['name'],
      json["cover_url"], 
      json["author_name"],
      json["genre"],
      reviewsObject.reviews,
    );
  }
}

class Books {
  List<Book> books;

  Books(this.books);

  factory Books.fromJson(Map<String, dynamic> json) {
    List<dynamic> bookMaps = json["books"];
    List<Book> bookList;

    bookList = bookMaps.map((book) {
      Reviews reviewsObject = Reviews.fromJson(book["reviews"]);
      return Book(
        book["id"]!,
        book["name"]!,
        book["cover_url"]!,
        book["author_name"]!,
        book["genre"]!,
        reviewsObject.reviews,
      );
    }).toList();
    return Books(bookList);
  }
}
