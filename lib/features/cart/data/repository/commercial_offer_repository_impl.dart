import 'package:henri_potier_riverpod/features/cart/data/remote/commercial_offer_api.dart';
import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';
import 'package:henri_potier_riverpod/features/cart/domain/repositories/commercial_offer_repository.dart';

class CommercialOfferRepositoryImpl implements CommercialOfferRepository {
  final CommercialOfferApi commercialOfferApi;

  CommercialOfferRepositoryImpl({required this.commercialOfferApi});

  @override
  Future<List<CommercialOffer>> getCommercialOffers(String isbns) async {
    final response = await commercialOfferApi.getCommercialOffers(isbns);
    return response.offers.map((offerModel) => offerModel.toDomain()).toList();
  }
}
