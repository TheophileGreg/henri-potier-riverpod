import 'package:flutter_test/flutter_test.dart';
import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_best_rebate_usecase.dart';

void main() {
  group('GetBestRebateUsecase', () {
    test('should return the correct rebate for OfferType.minus', () {
      final usecase = GetBestRebateUsecase(100, [
        const CommercialOffer(type: OfferType.minus, value: 10),
      ]);

      final result = usecase.call();

      expect(result, 10.0);
    });

    test('should return the correct rebate for OfferType.percentage', () {
      final usecase = GetBestRebateUsecase(100, [
        const CommercialOffer(type: OfferType.percentage, value: 10),
      ]);

      final result = usecase.call();

      expect(result, 10.0);
    });

    test('should return the correct rebate for OfferType.slice', () {
      final usecase = GetBestRebateUsecase(200, [
        const CommercialOffer(
            type: OfferType.slice, value: 10, sliceValue: 100),
      ]);

      final result = usecase.call();

      expect(result, 20.0);
    });

    test('should return the best rebate when multiple offers are provided', () {
      final usecase = GetBestRebateUsecase(200, [
        const CommercialOffer(type: OfferType.minus, value: 5),
        const CommercialOffer(type: OfferType.percentage, value: 10),
        const CommercialOffer(
            type: OfferType.slice, value: 10, sliceValue: 100),
      ]);

      final result = usecase.call();

      expect(result, 20.0);
    });

    test('should return 0.0 when no offers are provided', () {
      final usecase = GetBestRebateUsecase(200, []);

      final result = usecase.call();

      expect(result, 0.0);
    });
  });
}
