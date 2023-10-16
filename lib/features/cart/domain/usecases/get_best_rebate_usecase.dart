import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';

class GetBestRebateUsecase {
  final double total;
  final List<CommercialOffer> offers;

  GetBestRebateUsecase(this.total, this.offers);

  double call() {
    double maxRebate = 0.0;
    for (final offer in offers) {
      var rebate = calculateRebate(total, offer);
      if (rebate > maxRebate) {
        maxRebate = rebate;
      }
    }
    return maxRebate;
  }

  double calculateRebate(double price, CommercialOffer? offer) {
    if (offer == null) {
      return 0.0;
    }
    switch (offer.type) {
      case OfferType.minus:
        return offer.value.toDouble();
      case OfferType.percentage:
        return price * offer.value / 100;
      case OfferType.slice:
        var slice = price ~/ offer.sliceValue!;
        if (slice > 0) {
          return (slice * offer.value).toDouble();
        }
        return 0.0;
    }
  }
}
