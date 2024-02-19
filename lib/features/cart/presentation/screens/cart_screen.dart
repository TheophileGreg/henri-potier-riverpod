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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cart.length,
                  itemBuilder: (context, index) {
                    final book = cart.cart.keys.elementAt(index);

                    return Semantics(
                      label: "Elements dans le panier",
                      child: ListTile(
                        title: Text(book.title),
                        subtitle:
                            Text('Price: ${book.price} x ${cart.cart[book]}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                semanticLabel:
                                    'Enlever un livre ${book.title} du panier',
                              ),
                              onPressed: () {
                                ref
                                    .watch(cartProvider.notifier)
                                    .removeBookFromCart(book);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                semanticLabel:
                                    'Ajouter un livre ${book.title} au panier',
                              ),
                              onPressed: () {
                                ref
                                    .watch(cartProvider.notifier)
                                    .addBookToCart(book);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              TotalCard(cart: cart)
            ],
          );
        },
        loading: () => loadingScreen(),
        error: (error, stack) =>
            const Center(child: Text('Erreur lors du chargement des livres.')),
      ),
    );
  }
}
