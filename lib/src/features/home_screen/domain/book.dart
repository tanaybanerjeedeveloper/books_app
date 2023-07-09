class Book {
  final String id;
  final String title;
  final String author;
  final String publisher;
  final String publishDate;
  final String description;
  final String imgURL;
  final String downloadLink;
  final String previewLink;
  final String pages;

  Book(
      {required this.author,
      required this.description,
      required this.downloadLink,
      required this.id,
      required this.imgURL,
      required this.previewLink,
      required this.publishDate,
      required this.publisher,
      required this.title,
      required this.pages});
}
