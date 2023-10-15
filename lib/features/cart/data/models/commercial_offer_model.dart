import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart';

class CommercialOfferModel extends CommercialOffer {
  final String type;
  final double value;
  final double? sliceValue;

  CommercialOfferModel({
    required this.type,
    required this.value,
    this.sliceValue,
  }) : super(
          type: type,
          value: value,
          sliceValue: sliceValue,
        );

  factory CommercialOfferModel.fromJson(Map<String, dynamic> json) {
    return CommercialOfferModel(
      type: json['type'],
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      sliceValue: (json['sliceValue'] as num?)?.toDouble(),
    );
  }
}
