import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String isbn;
  final String title;
  final double price;
  final String cover;
  final List<String> synopsis;

  const Book({
    required this.isbn,
    required this.title,
    required this.price,
    required this.cover,
    required this.synopsis,
  });

  @override
  List<Object?> get props => [isbn, title, price, cover, synopsis];
}
