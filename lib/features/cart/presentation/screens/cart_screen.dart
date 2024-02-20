import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/commons/widgets/loading_screen.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/widgets/total_card.dart';
import 'package:henri_potier_riverpod/features/library/presentation/providers/library_providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final bookStatus = ref.watch(libraryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: bookStatus.when(
        data: (books) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cart.cart.length,
                    itemBuilder: (context, index) {
                      final book = cart.cart.keys.elementAt(index);

                      return ListTile(
                        visualDensity: const VisualDensity(vertical: 4),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FadeInImage(
                            excludeFromSemantics: true,
                            height: 200,
                            image: NetworkImage(book.cover),
                            placeholder: const AssetImage('assets/harry.jpg'),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            book.title,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        subtitle: RichText(
                            text: TextSpan(
                          text: 'Prix: ',
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text:
                                  '€${book.price * (cart.cart[book]?.toInt() ?? 0)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                              children: [
                                TextSpan(
                                    text: '\nUnités: ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text: '${cart.cart[book]}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ])
                              ],
                            ),
                          ],
                        )),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black.withOpacity(0.5)),
                                iconColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                              ),
                              icon: Semantics(
                                label:
                                    'Enlever un livre :  ${book.title} du panier',
                                child: const Icon(Icons.remove),
                              ),
                              onPressed: () {
                                if (cart.cart[book]?.toInt() == 1) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                                'Voulez-vous supprimer cette article du panier ?'),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all<double?>(0.0),
                                                  ),
                                                  child: const Text(
                                                    'Non',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    ref
                                                        .watch(cartProvider
                                                            .notifier)
                                                        .removeBookFromCart(
                                                            book);
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all<double?>(0.0),
                                                  ),
                                                  child: Text(
                                                    'Oui',
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.7)),
                                                  )),
                                            ],
                                          ));
                                } else {
                                  ref
                                      .watch(cartProvider.notifier)
                                      .removeBookFromCart(book);
                                }
                              },
                            ),
                            IconButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                iconColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                              ),
                              icon: Semantics(
                                label:
                                    'Rajouter un  livre : ${book.title} du panier',
                                child: const Icon(Icons.add),
                              ),
                              onPressed: () {
                                ref
                                    .watch(cartProvider.notifier)
                                    .addBookToCart(book);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      if (index != cart.cart.length - 1) {
                        return const Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 2,
                          color: Colors.grey,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                TotalCard(cart: cart)
              ],
            ),
          );
        },
        loading: () => loadingScreen(),
        error: (error, stack) =>
            const Center(child: Text('Erreur lors du chargement des livres.')),
      ),
    );
  }
}
