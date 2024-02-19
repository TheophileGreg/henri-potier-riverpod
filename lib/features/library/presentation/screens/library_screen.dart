// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
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
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(title: const Text('Bibliothèque d\'Henri Potier'), excludeHeaderSemantics: true),
        body: ref.watch(libraryProvider).when(
              data: (books) {
                return SingleChildScrollView(
                  child: LayoutGrid(
                    columnSizes: [1.fr, 1.fr],
                    rowSizes: const [auto, auto, auto, auto, auto],
                    rowGap: 5,
                    columnGap: 0,
                    children: [
                      for (var book in books)
                        GestureDetector(
                            onTap: () => GoRouter.of(context).pushNamed('bookDetails', extra: book),
                            child: BookListItem(book: book)),
                    ],
                  ),
                );
              },
              loading: () => loadingScreen(),
              error: (err, stack) => const Center(child: Text('Une erreur est survenue')),
            ),
        floatingActionButton: FloatingActionButton(
          elevation: 4,
          backgroundColor: Colors.blue,
          onPressed: () {
            GoRouter.of(context).pushNamed('cart');
          },
          tooltip: 'Go to cart',
          child: const Icon(
            Icons.shopping_cart_checkout,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
