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
      semanticContainer: true,
      child: Semantics(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FadeInImage(
              height: 180,
              excludeFromSemantics: true,
              // imageSemanticLabel:
              //     "Cette image représente la couverture du livre ${book.title}",
              image: NetworkImage(book.cover),
              placeholder: const AssetImage('assets/harry.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(book.title,
                  semanticsLabel: "Le titre du livre est ${book.title}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Semantics(
              label: "Le prix du livre ${book.title} est ${book.price} euros",
              readOnly: true,
              child: Text(
                "${book.price}€",
                // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3),
              ),
            ),
            ElevatedButton(
              key: Key('add_to_cart_button_${book.isbn}'),
              onPressed: () {
                ref.watch(cartProvider.notifier).addBookToCart(book);
              },
              child: Icon(
                Icons.add,
                semanticLabel:
                    "Button pour ajouter le livre ${book.title} dans le panier",
              ),
            )
          ],
        ),
      ),
    );
  }
}
