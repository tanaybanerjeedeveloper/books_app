import 'dart:convert';

import 'package:book_app/src/features/home_screen/domain/book.dart';
import 'package:book_app/src/utils/api_key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class BookListRepository {
  Future<List<Book>> fetchBookList(String title) async {
    // var uri = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=subject:$title&download=epub&orderBy=newest&key=$APIKey');

    try {
      var response = await http.get(Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=subject:$title&download=epub&orderBy=newest&key=$APIKey'));
      print('reponse: ${response.body}');
      var resp = json.decode(response.body);
      List<Book> bookList = [];
      bookList = (resp['totalItems'] == 0)
          ? []
          : resp['items'].map<Book>((item) {
              return Book(
                pages: item['volumeInfo']['pageCount'].toString(),
                author: item['volumeInfo']['authors'][0],
                description: item['volumeInfo']['description'],
                downloadLink: item['accessInfo']['pdf']['isAvailable'] == true
                    ? item['accessInfo']['pdf']['acsTokenLink']
                    : '',
                id: item['id'],
                imgURL: item['volumeInfo']['imageLinks']['thumbnail'],
                previewLink: item['volumeInfo']['previewLink'],
                publishDate: item['volumeInfo']['publishedDate'],
                publisher: item['volumeInfo']['publisher'],
                title: item['volumeInfo']['title'],
              );
            }).toList();
      print('success');
      return bookList;
    } catch (e) {
      print('error');
      throw Exception('something went wrong');
    }
  }
}

final bookListRepositoryProvider = Provider<BookListRepository>((ref) {
  return BookListRepository();
});

final fetchBookListProvider =
    FutureProvider.family<List<Book>, String>((ref, title) async {
  final bookListRepository = ref.watch(bookListRepositoryProvider);
  return bookListRepository.fetchBookList(title);
});
