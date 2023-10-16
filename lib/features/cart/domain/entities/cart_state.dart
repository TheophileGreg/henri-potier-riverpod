import 'package:equatable/equatable.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';

class CartState extends Equatable {
  Map<Book, int> cart;
  final bool isLoading;
  final double totalPrice;
  final double rebate;
  final double finalPrice;

  CartState(
    this.isLoading,
    this.totalPrice,
    this.rebate,
    this.finalPrice, {
    required this.cart,
  });

  CartState copyWith({
    Map<Book, int>? cart,
    bool? isLoading,
    double? totalPrice,
    double? rebate,
    double? finalPrice,
  }) {
    return CartState(
      isLoading ?? this.isLoading,
      totalPrice ?? this.totalPrice,
      rebate ?? this.rebate,
      finalPrice ?? this.finalPrice,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [isLoading, totalPrice, rebate, finalPrice, cart];
}
