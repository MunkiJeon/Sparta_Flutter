import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'book.dart';
import 'main.dart';

class BookService extends ChangeNotifier {
  BookService() {
    loadLikedBookList();
  }

  List<Book> bookList = []; // 책 목록
  List<Book> likedBookList = []; //좋아요 한 책 목록

  void toggleLikeBook({required Book book}) {
    String bookId = book.id;
    if (likedBookList.map((book) => book.id).contains(bookId)) {
      likedBookList.removeWhere((book) => book.id == bookId);
    } else {
      likedBookList.add(book);
    }
    notifyListeners();
  }

  void search(String q) async {
    bookList.clear();

    if (q.isNotEmpty) {
      Response res = await Dio().get(
        "https://www.googleapis.com/books/v1/volumes?q=$q&startIndex=0&maxResults=40",
      );
      List items = res.data["items"];

      for (Map<String, dynamic> item in items) {
        Book book = Book(
          id: item['id'],
          title: item['volumeInfo']['title'] ?? "",
          subtitle: item['volumeInfo']['subtitle'] ?? "",
          authors: item['volumeInfo']['authors'] ?? [],
          publishedDate: item['volumeInfo']['publishedDate'] ?? "",
          thumbnail: item['volumeInfo']['imageLinks']?['thumbnail'] ??
              "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg",
          previewLink: item['volumeInfo']['previewLink'] ?? "",
        );
        bookList.add(book);
      }
    }
    notifyListeners();
    saveLikedBookList();
  }

  saveLikedBookList() {
    List likedBookJsonList =
        likedBookList.map((book) => book.toJson()).toList();
    // [{"content": "1"}, {"content": "2"}]

    String jsonString = jsonEncode(likedBookJsonList);
    // '[{"content": "1"}, {"content": "2"}]'

    prefs.setString('likedBookList', jsonString);
  }

  loadLikedBookList() {
    String? jsonString = prefs.getString('likedBookList');
    // '[{"content": "1"}, {"content": "2"}]'

    if (jsonString == null) return; // null 이면 로드하지 않음

    List likedBookJsonList = jsonDecode(jsonString);
    // [{"content": "1"}, {"content": "2"}]

    likedBookList =
        likedBookJsonList.map((json) => Book.fromJson(json)).toList();
  }
}
