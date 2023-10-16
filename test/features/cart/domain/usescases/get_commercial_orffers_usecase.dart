import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_commercial_offers_usecase.dart';
import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';
import 'package:henri_potier_riverpod/features/cart/domain/repositories/commercial_offer_repository.dart';
import 'package:get_it/get_it.dart';

import 'get_commercial_orffers_usecase.mocks.dart';

@GenerateMocks([CommercialOfferRepository])
void main() {
  late GetCommercialOffersUseCase usecase;
  late CommercialOfferRepository mockCommercialOfferRepository;

  setUp(() {
    GetIt.instance.reset();

    mockCommercialOfferRepository = GetIt.instance
        .registerSingleton<CommercialOfferRepository>(
            MockCommercialOfferRepository());
    usecase = GetCommercialOffersUseCase(mockCommercialOfferRepository);
  });

  test('should fetch commercial offers for the provided isbn', () async {
    const isbn = "123";
    final mockOffers = [
      const CommercialOffer(type: OfferType.percentage, value: 5),
      const CommercialOffer(type: OfferType.minus, value: 7),
    ];
    when(mockCommercialOfferRepository.getCommercialOffers(isbn))
        .thenAnswer((_) async => mockOffers);

    final result = await usecase.call(isbns: isbn);

    expect(result, mockOffers);
    verify(mockCommercialOfferRepository.getCommercialOffers(isbn)).called(1);
    verifyNoMoreInteractions(mockCommercialOfferRepository);
  });
}
