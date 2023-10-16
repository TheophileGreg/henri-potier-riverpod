import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';

class BookModel extends Book {
  final String isbn;
  final String title;
  final double price;
  final String cover;
  final List<String> synopsis;

  const BookModel({
    required this.isbn,
    required this.title,
    required this.price,
    required this.cover,
    required this.synopsis,
  }) : super(
          isbn: isbn,
          title: title,
          price: price,
          cover: cover,
          synopsis: synopsis,
        );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      isbn: json['isbn'],
      title: json['title'],
      price: json['price'].toDouble(),
      cover: json['cover'],
      synopsis: List<String>.from(json['synopsis']),
    );
  }
}
