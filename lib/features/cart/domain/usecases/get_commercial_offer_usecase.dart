import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';
import 'package:henri_potier_riverpod/features/cart/domain/repositories/commercial_offer_repository.dart';

class GetCommercialOfferUseCase {
  final CommercialOfferRepository _repository;

  GetCommercialOfferUseCase(this._repository);

  Future<List<CommercialOffer>> execute({required List<String> isbns}) async {
    return await _repository.getCommercialOffers(isbns);
  }
}
