import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:henri_potier_riverpod/features/cart/domain/entities/cart_state.dart';
import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_commercial_offers_usecase.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../riverpod_utils.dart';
import 'cart_providers_test.mocks.dart';

@GenerateMocks([GetCommercialOffersUseCase])
void main() {
  late final GetCommercialOffersUseCase mockGetCommercialOffersUseCase;
  late ProviderContainer container;
  setUp(() async {
    await GetIt.instance.reset();

    mockGetCommercialOffersUseCase = GetIt.instance
        .registerSingleton<GetCommercialOffersUseCase>(
            MockGetCommercialOffersUseCase());
    container = createContainer();
  });

  const book1 = Book(
      isbn: "123",
      title: "Test Book 1",
      price: 10.0,
      cover: "cover1.jpg",
      synopsis: ["Synopsis 1 part 1", "Synopsis 1 part 2"]);

  test('Initial state of cart provider', () {
    expect(
      container.read(cartProvider.notifier).state,
      equals(CartState(false, 0, 0, 0, cart: const {})),
    );
  });

  test(
      'should_update_cart_state_and_apply_best_commercial_offer_when_book_is_added',
      () async {
    when(mockGetCommercialOffersUseCase(isbns: '123')).thenAnswer((_) async => [
          const CommercialOffer(type: OfferType.percentage, value: 5),
          const CommercialOffer(type: OfferType.minus, value: 7),
          const CommercialOffer(
              type: OfferType.slice, value: 10, sliceValue: 100)
        ]);

    final states = [];
    container.listen<CartState>(
      cartProvider,
      (oldState, newState) {
        states.add(newState);
      },
    );

    final provider = container.read(cartProvider.notifier);
    await provider.addBookToCart(book1);

    expect(
      states[0],
      equals(CartState(true, 10.0, 0.0, 0.0, cart: {
        const Book(
            isbn: "123",
            title: "Test Book 1",
            price: 10.0,
            cover: "cover1.jpg",
            synopsis: ["Synopsis 1 part 1", "Synopsis 1 part 2"]): 1
      })),
    );

    expect(
      states[1],
      equals(CartState(false, 10.0, 7.0, 3.0, cart: {
        const Book(
            isbn: "123",
            title: "Test Book 1",
            price: 10.0,
            cover: "cover1.jpg",
            synopsis: ["Synopsis 1 part 1", "Synopsis 1 part 2"]): 1
      })),
    );
  });
}
