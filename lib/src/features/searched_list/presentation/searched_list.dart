import 'package:book_app/src/common_widgets/error_msg.dart';
import 'package:book_app/src/features/home_screen/data/book_list_repository.dart';
import 'package:book_app/src/features/searched_list/data/search_list_repository.dart';
import 'package:book_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchedList extends ConsumerWidget {
  //const SearchedList({super.key});
  final text;
  SearchedList({required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(fetchSearchListProvider(text));
    final mediaQuery = MediaQuery.of(context).size;
    print('text: $text');
    return data.when(
      data: (data) {
        return Scaffold(
          body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    width: mediaQuery.width * 0.3,
                    height: mediaQuery.height * 0.2,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data[index].imgURL),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.width * 0.09,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: mediaQuery.width * 0.5,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('by ${data[index].author}'),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff03045E)),
                          onPressed: () {
                            context.pushNamed(AppRoute.bookDetails.name,
                                queryParams: {
                                  'title': data[index].title,
                                  'publisher': data[index].publisher,
                                  'publishDate': data[index].publishDate,
                                  'imageURL': data[index].imgURL,
                                  'pages': data[index].pages.toString(),
                                  'author': data[index].author,
                                  'description': data[index].description,
                                  'downloadLink': data[index].previewLink,
                                });
                          },
                          child: Text('Details')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, st) => Scaffold(
        body: Center(
          child: ErrorMessageWidget(error.toString()),
        ),
      ),
      loading: () => Scaffold(
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    Scaffold(
      body: Center(
        child: Text('searched list'),
      ),
    );
  }
}
