import 'package:flutter/material.dart';

import '../Models/book.dart';

class BooksProvider with ChangeNotifier{
  final Set<int> _bookmarked = {};

  void addToBookmarked(int bookID) {
    _bookmarked.add(bookID);
    notifyListeners();
  }

  void removeFromBookmarked(int bookID) {
    _bookmarked.remove(bookID);
    notifyListeners();
  }

  List<int> get bookmarkedIDs {
    return _bookmarked.toList();
  }

  bool isBookmarked(int bookID){
    return _bookmarked.contains(bookID);
  }

}