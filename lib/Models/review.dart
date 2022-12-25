class Review {
  int reviewId;
  int bookId;
  String username;
  String text;

  Review(
    this.reviewId,
    this.bookId,
    this.username,
    this.text,
  );

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      json["id"],
      json['book_id'],
      json["username"],
      json["text"],
    );
  }
}

class Reviews {
  List<Review> reviews;

  Reviews(this.reviews);

  factory Reviews.fromJson(List json) {
    List<Review> reviewsList;
    reviewsList = json.map((review) {
      return Review(
        review["id"]!,
        review["book_id"]!,
        review["username"]!,
        review["text"]!,
      );
    }).toList();
    return Reviews(reviewsList);
  }
}
