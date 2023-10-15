import 'package:equatable/equatable.dart';

class CommercialOffer extends Equatable {
  final String type;
  final double value;
  final double? sliceValue;

  CommercialOffer({
    required this.type,
    required this.value,
    this.sliceValue,
  });

  @override
  List<Object?> get props => [type, value, sliceValue];
}
