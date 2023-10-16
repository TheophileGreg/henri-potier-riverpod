import 'package:henri_potier_riverpod/features/cart/data/models/commercial_offer_model.dart';

class CommercialOffersResponse {
  final List<CommercialOfferModel> offers;

  CommercialOffersResponse({required this.offers});

  factory CommercialOffersResponse.fromJson(Map<String, dynamic> json) {
    return CommercialOffersResponse(
      offers: (json['offers'] as List<dynamic>)
          .map((item) => CommercialOfferModel.fromJson(item))
          .toList(),
    );
  }
}
