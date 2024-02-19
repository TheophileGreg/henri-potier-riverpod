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
            excludeFromSemantics: true,
            height: 200,
            image: NetworkImage(book.cover),
            placeholder: const AssetImage('assets/harry.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(book.title, overflow: TextOverflow.ellipsis, maxLines: 3),
          ),
          Expanded(
              child: Text(
            "${book.price}€",
            semanticsLabel: '${book.price} euros',
          )),
          ElevatedButton(
            key: Key('add_to_cart_button_${book.isbn}'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              iconColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              ref.watch(cartProvider.notifier).addBookToCart(book);
            },
            child: Semantics(
                label: 'Add ${book.title} to cart',
                button: true,
                enabled: true,
                child: const Icon(
                  Icons.add,
                ) // Si on met le semantics entant que parent de IconButton le semantics ne fonctionne pas ,
                ),
          )
        ],
      ),
    );
  }
}
