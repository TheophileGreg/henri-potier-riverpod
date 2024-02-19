// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:henri_potier_riverpod/commons/widgets/loading_screen.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/screens/cart_screen.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:henri_potier_riverpod/features/library/presentation/providers/library_providers.dart';
import 'package:henri_potier_riverpod/features/library/presentation/widgets/book_list_item.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bibliothèque d\'Henri Potier'),
      ),
      body: ref.watch(libraryProvider).when(
            data: (books) => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return GestureDetector(
                      onTap: () {
                        GoRouter.of(context)
                            .pushNamed('bookDetails', extra: book);
                      },
                      child: BookListItem(book: book));
                }),
            loading: () => loadingScreen(),
            error: (err, stack) =>
                const Center(child: Text('Une erreur est survenue')),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed('cart');
        },
        //tooltip: 'Voir le panier',
        child: const Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }
}
