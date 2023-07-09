import 'dart:convert';

import 'package:book_app/src/features/home_screen/domain/book.dart';
import 'package:book_app/src/utils/api_key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class SearchedListRepository {
  Future<List<Book>> fetchSearchList(String text) async {
    // var response = await http.get(Uri.parse(
    //     'https://www.googleapis.com/books/v1/volumes?q=intitle:$text&maxResult=40&download=epub&orderBy=newest&key=$APIKey'));
    // print('response:-------------------->>> $response');

    var response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=intitle:$text&maxResult=40&download=epub&orderBy=newest&key=$APIKey'));
    print('response---------->> ${response.statusCode}');
    if (response.statusCode == 200) {
      // print('response:-------> $response');
      var resp = json.decode(response.body);
      List<Book> bookList = [];
      bookList = resp['items'].map<Book>((item) {
        return Book(
          pages: (item['volumeInfo']['pageCount'] == null)
              ? '0'
              : item['volumeInfo']['pageCount'].toString(),
          author: item['volumeInfo']['authors'][0],
          description: item['volumeInfo']['description'],
          // downloadLink: item['accessInfo']['pdf']['isAvailable'] == true
          //     ? item['accessInfo']['pdf']['acsTokenLink']
          //     : '',
          id: item['id'],
          imgURL: item['volumeInfo']['imageLinks']['thumbnail'],
          previewLink: item['volumeInfo']['previewLink'],
          publishDate: item['volumeInfo']['publishedDate'],
          publisher: item['volumeInfo']['publisher'],
          title: item['volumeInfo']['title'],
        );
      }).toList();
      print('book-list------->> $bookList');
      return bookList;
    } else {
      print('error');
      throw Exception('something went wrong');
    }
  }
}

final searchedListRepositoryProvider = Provider<SearchedListRepository>((ref) {
  return SearchedListRepository();
});

final fetchSearchListProvider =
    FutureProvider.family<List<Book>, String>((ref, text) async {
  final searchedListRepository = ref.watch(searchedListRepositoryProvider);

  return searchedListRepository.fetchSearchList(text);
});
