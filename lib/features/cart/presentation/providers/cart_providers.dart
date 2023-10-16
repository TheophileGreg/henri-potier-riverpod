import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/core/injection_container.dart';
import 'package:henri_potier_riverpod/features/cart/domain/entities/cart_state.dart';
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_best_rebate_usecase.dart';
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_cart_total_usecase.dart';
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_commercial_offers_usecase.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) => CartNotifier());

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState(false, 0, 0, 0, cart: {}));

  Future<void> addBookToCart(Book book) async {
    state.cart[book] = (state.cart[book] ?? 0) + 1;
    state = state.copyWith(
        isLoading: true,
        totalPrice: GetCartTotalUsecase(state.cart)(),
        cart: state.cart);

    await updatePrice();
  }

  Future<void> removeBookFromCart(Book book) async {
    state.cart[book] = (state.cart[book] ?? 1) - 1;
    if (state.cart[book] == 0) {
      state.cart.remove(book);
    }
    state = state.copyWith(
        isLoading: true,
        totalPrice: GetCartTotalUsecase(state.cart)(),
        cart: state.cart);

    await updatePrice();
  }

  Future<void> updatePrice() async {
    final commercialOffers = await storeLocator<GetCommercialOffersUseCase>()(
        isbns: state.cart.keys.map((e) => e.isbn).toList().join(", "));
    final bestRebate =
        GetBestRebateUsecase(state.totalPrice, commercialOffers)();
    state = state.copyWith(
        rebate: bestRebate,
        finalPrice: state.totalPrice - bestRebate,
        isLoading: false);
  }
}
