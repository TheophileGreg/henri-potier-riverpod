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

                    return MergeSemantics(
                      child: ListTile(
                        title: Text(book.title),
                        subtitle:
                            Text('Price: ${book.price} x ${cart.cart[book]}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Semantics(
                              label: 'Remove one ${book.title} from cart',
                              enabled: true,
                              child: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  ref
                                      .watch(cartProvider.notifier)
                                      .removeBookFromCart(book);
                                },
                              ),
                            ),
                            Semantics(
                              label: 'Add one ${book.title} from cart',
                              enabled: true,
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  ref
                                      .watch(cartProvider.notifier)
                                      .addBookToCart(book);
                                },
                              ),
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
