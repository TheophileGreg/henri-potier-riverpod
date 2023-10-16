import 'package:flutter_test/flutter_test.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_cart_total_usecase.dart';

void main() {
  group('GetCartTotalUsecase', () {
    const book1 = Book(
        isbn: "123",
        title: "Test Book 1",
        price: 10.0,
        cover: "",
        synopsis: []);

    const book2 = Book(
        isbn: "456",
        title: "Test Book 2",
        price: 20.0,
        cover: "",
        synopsis: []);

    test('should return zero if the cart is empty', () {
      final usecase = GetCartTotalUsecase({});

      final result = usecase.call();

      expect(result, 0.0);
    });

    test('should correctly calculate the total for one book', () {
      final usecase = GetCartTotalUsecase({
        book1: 1,
      });

      final result = usecase.call();

      expect(result, 10.0);
    });

    test('should correctly calculate the total for multiple books', () {
      final usecase = GetCartTotalUsecase({
        book1: 1,
        book2: 2,
      });

      final result = usecase.call();

      expect(result, 50.0); // 10 * 1 + 20 * 2 = 50
    });

    test(
        'should correctly calculate the total for multiple quantities of a book',
        () {
      final usecase = GetCartTotalUsecase({
        book1: 3,
      });

      final result = usecase.call();

      expect(result, 30.0); // 10 * 3 = 30
    });
  });
}
