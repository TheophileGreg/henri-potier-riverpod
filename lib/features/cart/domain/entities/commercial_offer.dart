import 'package:equatable/equatable.dart';

enum OfferType {
  percentage,
  minus,
  slice,
}

class CommercialOffer extends Equatable {
  final OfferType type;
  final int value;
  final int? sliceValue;

  const CommercialOffer({
    required this.type,
    required this.value,
    this.sliceValue,
  });

  @override
  List<Object?> get props => [type, value, sliceValue];
}
