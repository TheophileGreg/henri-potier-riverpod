import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/commons/widgets/loading_screen.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/screens/cart_screen.dart';
import 'package:henri_potier_riverpod/features/library/presentation/providers/library_providers.dart';
import 'package:henri_potier_riverpod/features/library/presentation/widgets/library_content.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bibliothèque d\'Henri Potier'),
      ),
      body: ref.watch(libraryProvider).when(
            data: (books) => libraryContent(
              ref,
              books,
            ),
            loading: () => loadingScreen(),
            error: (err, stack) =>
                const Center(child: Text('Une erreur est survenue')),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        tooltip: 'Voir le panier',
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
