import 'package:book_app/src/common_widgets/error_msg.dart';
import 'package:book_app/src/features/home_screen/data/book_list_repository.dart';
import 'package:book_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookList extends ConsumerWidget {
  //const BookList({super.key});
  final title;
  BookList(this.title);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListData = ref.watch(fetchBookListProvider(title));
    final mediaQuery = MediaQuery.of(context).size;
    return bookListData.when(
      data: (data) {
        print('data: $data');
        return ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
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
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 10.0,
                ),
                height: mediaQuery.height * 0.15,
                width: mediaQuery.width * 0.35,
                //color: Colors.black,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(data[index].imgURL),
                  fit: BoxFit.cover,
                )),
              ),
            );
          },
        );
      },
      error: (error, st) => Center(
        child: ErrorMessageWidget(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
