import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';

class CommercialOfferModel extends CommercialOffer {
  final OfferType type;
  final int value;
  final int? sliceValue;

  CommercialOfferModel({
    required this.type,
    required this.value,
    this.sliceValue,
  }) : super(
          type: type,
          value: value,
          sliceValue: sliceValue,
        );

  CommercialOffer toDomain() {
    return CommercialOffer(
      type: type,
      value: value,
      sliceValue: sliceValue,
    );
  }

  factory CommercialOfferModel.fromJson(Map<String, dynamic> json) =>
      CommercialOfferModel(
          type: OfferType.values
              .firstWhere((ot) => ot.toString() == "OfferType.${json['type']}"),
          value: json['value'],
          sliceValue: json['sliceValue']);
}
