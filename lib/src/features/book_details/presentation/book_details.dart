import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsScreen extends StatelessWidget {
  //const BookDetailsScreen({super.key});
  final String imgURL;
  final String title;
  final String publisher;
  final String pages;
  //final String language;
  final String publishDate;
  final String description;
  final String author;
  final String douwnloadLink;

  BookDetailsScreen(
      {required this.description,
      required this.imgURL,
      required this.pages,
      required this.publishDate,
      required this.publisher,
      required this.title,
      required this.author,
      required this.douwnloadLink});

  @override
  Widget build(BuildContext context) {
    print('publisher: $publisher');
    print('imgURL: $imgURL');
    print('fileName: ${douwnloadLink.split('/').last}');
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: mediaQuery.height * 0.05,
            ),
            Center(
              child: Container(
                height: mediaQuery.height * 0.25,
                width: mediaQuery.width * 0.45,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(imgURL),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.02,
            ),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.01,
            ),
            Center(
              child: Text('by $author'),
            ),
            SizedBox(
              height: mediaQuery.height * 0.025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 5.0, horizontal: mediaQuery.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Pages'),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        pages,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Publisher',
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                        width: mediaQuery.width * 0.4,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(publisher,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Published date'),
                      SizedBox(
                        height: 2,
                      ),
                      Text(publishDate,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 5.0, horizontal: mediaQuery.width * 0.05),
              child: Row(
                children: [
                  Text(
                    'Summary',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 5.0, horizontal: mediaQuery.width * 0.05),
              child: Text(description),
            ),
            SizedBox(
              height: mediaQuery.height * 0.15,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: mediaQuery.height * 0.13,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              print('downloadLink: $douwnloadLink');
              await launchUrl(Uri.parse(douwnloadLink));
              // if (await canLaunchUrl(Uri.parse(douwnloadLink))) {
              //   await launchUrl(Uri.parse(
              //       'https://blog.logrocket.com/launching-urls-flutter-url_launcher/'));
              // } else {
              //   throw 'Could not launch url';
              // }
              // var splitLink = douwnloadLink.split('/').last;
              // var link = splitLink.split('?').first;
              // print('link:----------$link');

              // openFile(
              //   url:
              //       'https://st.depositphotos.com/2274151/3518/i/600/depositphotos_35186549-stock-photo-sample-grunge-red-round-stamp.jpg',
              //   fileName:
              //       'depositphotos_35186549-stock-photo-sample-grunge-red-round-stamp.jpg.pdf',
              // );
            },
            child: Text('VIEW BOOK'),
          ),
        ),
      ),
    );
  }

  // Future openFile({required String url, required String fileName}) async {
  //   print('url: $url');
  //   print('fileName: $fileName');
  //   final file = await downloadFile(url, fileName!);
  //   if (file == null) return;

  //   print('Path: ${file.path}');

  //   OpenFile.open(file.path);
  // }

  // Future<File?> downloadFile(String url, String name) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final file = File('${appStorage.path}/$name');
  //   print(file);
  //   try {
  //     final response = await Dio().get(url,
  //         options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           receiveTimeout: 0,
  //         ));
  //     print('response: $response');

  //     final raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     await raf.close();

  //     return file;
  //   } catch (e) {
  //     print('error');
  //     return null;
  //   }
  // }
}
