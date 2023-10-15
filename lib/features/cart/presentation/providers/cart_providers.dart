import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, int>>(
    (ref) => CartNotifier());

class CartNotifier extends StateNotifier<Map<String, int>> {
  CartNotifier() : super({});

  void addBookToCart(String isbn) {
    if (state.containsKey(isbn)) {
      state = {...state, isbn: state[isbn]! + 1};
    } else {
      state = {...state, isbn: 1};
    }
  }

  void removeBookFromCart(String isbn) {
    if (state.containsKey(isbn)) {
      if (state[isbn]! > 1) {
        state = {...state, isbn: state[isbn]! - 1};
      } else {
        state = {...state}..remove(isbn);
      }
    }
  }
}
