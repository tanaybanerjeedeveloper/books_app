import 'package:book_app/src/common_widgets/book_list.dart';
import 'package:book_app/src/features/searched_list/presentation/searched_list.dart';
import 'package:book_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  //const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    TextEditingController searchText = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BookStore',
          style: TextStyle(),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: mediaQuery.height * 0.05,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 55.0),
              child: TextField(
                controller: searchText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Search Book...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade600, width: 0.0),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade600, width: 0.0),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.03,
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Text('SEARCH'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.white,
            //     foregroundColor:
            //   ),
            // ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchedList(
                      text: searchText.text,
                    ),
                  ),
                );
              },
              child: Text('Search'),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff03045E),
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 25.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Thriller',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppRoute.mainBookList.name, queryParams: {
                        'title': 'thriller',
                      });
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.02,
            ),
            SizedBox(
              height: mediaQuery.height * 0.2,
              child: BookList('thriller'),
            ),
            SizedBox(
              height: mediaQuery.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 25.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fantasy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppRoute.mainBookList.name, queryParams: {
                        'title': 'fantasy',
                      });
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.02,
            ),
            SizedBox(
              height: mediaQuery.height * 0.2,
              child: BookList('fantasy'),
            ),
            SizedBox(
              height: mediaQuery.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
