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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FadeInImage(
            height: 200,
            image: NetworkImage(book.cover),
            placeholder: const AssetImage('assets/harry.jpg'),
          ),
          Text(
            book.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text("${book.price}€"),
          ElevatedButton(
            key: Key('add_to_cart_button_${book.isbn}'),
            onPressed: () {
              ref.watch(cartProvider.notifier).addBookToCart(book);
            },
            child: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
    );
  }
}
