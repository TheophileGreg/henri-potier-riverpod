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
    return Semantics(
      label: "Détails du livre",
      button: true,
      enabled: true,
      container: true,
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage(
                  excludeFromSemantics: true,
                  height: 200,
                  image: NetworkImage(book.cover),
                  placeholder: const AssetImage('assets/harry.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  book.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "${book.price}€",
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                semanticsLabel: '${book.price} euros',
              ),
              ElevatedButton(
                key: Key('add_to_cart_button_${book.isbn}'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  iconColor: MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(4)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      dismissDirection: DismissDirection.horizontal,
                      backgroundColor: Colors.black,
                      margin: const EdgeInsets.all(20),
                      behavior: SnackBarBehavior.floating,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      content: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  '${book.title} est ajoutée dans votre panier')),
                          const Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                          )
                        ],
                      )));
                  ref.watch(cartProvider.notifier).addBookToCart(book);
                },
                child: Semantics(
                    label: 'Ajouter ${book.title} au panier',
                    button: true,
                    enabled: true,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Ajoutez au panier',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Icon(Icons.add_shopping_cart),
                      ],
                    ) // Si on met le semantics entant que parent de IconButton le semantics ne fonctionne pas ,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
