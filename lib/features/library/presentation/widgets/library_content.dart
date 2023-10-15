import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';

libraryContent(WidgetRef ref, List<Book> books) {
  return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          child: Column(
            children: [
              Expanded(
                child: Image.network(book.cover, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(book.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Text("${book.price}€"),
              ElevatedButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).addBookToCart(book.isbn);
                },
                child: const Icon(Icons.add),
              )
            ],
          ),
        );
      });
}
