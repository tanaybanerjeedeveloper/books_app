import 'package:book_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'Bookstore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          //primary: Colors.grey,
          secondary: Color(0xff03045E),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
