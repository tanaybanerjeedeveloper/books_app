import 'package:book_app/src/features/book_details/presentation/book_details.dart';
import 'package:book_app/src/features/home_screen/presentation/home_screen.dart';
import 'package:book_app/src/features/main_book_list/presentation/main_book_list.dart';
import 'package:book_app/src/features/search/presentation/search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  bookDetails,
  searchScreen,
  mainBookList,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) {
        return HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'search',
          name: AppRoute.searchScreen.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: SearchScreen(),
            );
          },
        ),
        GoRoute(
          path: 'book-details',
          name: AppRoute.bookDetails.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: BookDetailsScreen(
                author: state.queryParams['author']!,
                description: state.queryParams['description']!,
                douwnloadLink: state.queryParams['downloadLink']!,
                imgURL: state.queryParams['imageURL']!,
                pages: state.queryParams['pages']!,
                publishDate: state.queryParams['publishDate']!,
                publisher: state.queryParams['publisher']!,
                title: state.queryParams['title']!,
              ),
            );
          },
        ),
        GoRoute(
          path: 'main-book-list',
          name: AppRoute.mainBookList.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: MainBookList(
                title: state.queryParams['title']!,
              ),
            );
          },
        )
      ],
    ),
  ],
);
