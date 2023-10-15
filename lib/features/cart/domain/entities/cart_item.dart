import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';

class CartItem {
  final Book book;
  final int quantity;

  CartItem({required this.book, required this.quantity});
}
