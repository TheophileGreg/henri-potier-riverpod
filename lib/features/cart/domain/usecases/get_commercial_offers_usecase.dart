import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';
import 'package:henri_potier_riverpod/features/cart/domain/repositories/commercial_offer_repository.dart';

class GetCommercialOffersUseCase {
  final CommercialOfferRepository _repository;

  GetCommercialOffersUseCase(this._repository);

  Future<List<CommercialOffer>> call({required String isbns}) async {
    return await _repository.getCommercialOffers(isbns);
  }
}
