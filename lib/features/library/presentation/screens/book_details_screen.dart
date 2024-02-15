import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';

class BookDetailsScreen extends ConsumerWidget {
  final Book book;
  const BookDetailsScreen({
    required this.book,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: Text(book.title)),
        body: MergeSemantics(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                FadeInImage(
                  imageSemanticLabel:
                      "Cette image représente la couverture du livre ${book.title}",
                  image: NetworkImage(book.cover),
                  placeholder: const AssetImage('assets/harry.jpg'),
                ),
                const SizedBox(height: 16.0),
                Text(
                  book.title,
                  semanticsLabel: "Le titre du livre est ${book.title}",
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'ISBN: ${book.isbn}',
                  semanticsLabel:
                      "L'dentifiant du livre ${book.title} est ${book.isbn}",
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Prix: \$${book.price.toStringAsFixed(2)}',
                  semanticsLabel:
                      "Le prix du livre ${book.title} est ${book.price}",
                ),
                const SizedBox(height: 16.0),
                ...book.synopsis.map((line) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(line),
                    )),
                ElevatedButton(
                  onPressed: () {
                    ref.watch(cartProvider.notifier).addBookToCart(book);
                  },
                  child: Text(
                    'Ajouter au panier',
                    semanticsLabel:
                        "Button pour ajouter le livre ${book.title} dans le panier",
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
