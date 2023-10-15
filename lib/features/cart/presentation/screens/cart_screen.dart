import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/commons/widgets/loading_screen.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:henri_potier_riverpod/features/library/presentation/providers/library_providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final booksAsyncValue = ref.watch(libraryProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: booksAsyncValue.when(
        data: (books) {
          return ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final isbn = cart.keys.elementAt(index);
              final book = books.firstWhere((b) => b.isbn == isbn);
              return ListTile(
                title: Text(book.title),
                subtitle: Text('Price: ${book.price} x ${cart[isbn]}'),
                // TODO add button to remove book from cart
              );
            },
          );
        },
        loading: () => loadingScreen(),
        error: (error, stack) =>
            Center(child: Text('Erreur lors du chargement des livres.')),
      ),
    );
  }
}
