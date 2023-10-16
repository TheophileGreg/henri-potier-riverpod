import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';

class BookListItem extends ConsumerWidget {
  const BookListItem({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(book.cover, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(book.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text("${book.price}€"),
          ElevatedButton(
            onPressed: () {
              ref.watch(cartProvider.notifier).addBookToCart(book);
            },
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
