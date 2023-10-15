import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';

abstract class CommercialOfferRepository {
  Future<List<CommercialOffer>> getCommercialOffers(List<String> isbn);
}
