import 'package:book_app/src/common_widgets/error_msg.dart';
import 'package:book_app/src/features/home_screen/data/book_list_repository.dart';
import 'package:book_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainBookList extends ConsumerWidget {
  final title;
  MainBookList({this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(fetchBookListProvider(title));
    print('data-----: $data');
    print('title: $title');
    final mediaQuery = MediaQuery.of(context).size;
    return data.when(
      data: (data) {
        print('length: ----- ${data.length}');
        return Scaffold(
          appBar: AppBar(
            title: Text('Book List'),
            elevation: 0.0,
          ),
          body: GridView.builder(
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // crossAxisSpacing: 5,
              // mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () =>
                  context.pushNamed(AppRoute.bookDetails.name, queryParams: {
                'title': data[index].title,
                'publisher': data[index].publisher,
                'publishDate': data[index].publishDate,
                'imageURL': data[index].imgURL,
                'pages': data[index].pages.toString(),
                'author': data[index].author,
                'description': data[index].description,
                'downloadLink': data[index].previewLink,
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Container(
                  height: mediaQuery.height * 0.15,
                  width: mediaQuery.width * 0.35,
                  //color: Colors.red,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(data[index].imgURL),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
          ),
        );
      },
      error: (error, st) => Center(
        child: ErrorMessageWidget(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     title: Text('Book List'),
    //     elevation: 0.0,
    //   ),
    //   body: GridView.builder(
    //     itemCount: 20,
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       // crossAxisSpacing: 5,
    //       // mainAxisSpacing: 5,
    //     ),
    //     itemBuilder: (context, index) => Padding(
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: 30,
    //         vertical: 20,
    //       ),
    //       child: Container(
    //         // margin: EdgeInsets.symmetric(
    //         //   vertical: 0.0,
    //         //   horizontal: 10.0,
    //         // ),
    //         height: mediaQuery.height * 0.15,
    //         width: mediaQuery.width * 0.35,
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    // );
  }
}
