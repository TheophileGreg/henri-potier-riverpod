import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';

class GetCartTotalUsecase {
  final Map<Book, int> cart;

  GetCartTotalUsecase(this.cart);

  double call() {
    double total = 0;
    cart.forEach((book, quantity) {
      total += book.price * quantity;
    });
    return total;
  }
}
