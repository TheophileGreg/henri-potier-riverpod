import 'package:flutter/material.dart';
import 'package:henri_potier_riverpod/commons/widgets/shimmer_text.dart';
import 'package:henri_potier_riverpod/features/cart/domain/entities/cart_state.dart';

class TotalCard extends StatelessWidget {
  const TotalCard({
    super.key,
    required this.cart,
  });

  final CartState cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prix : €${cart.totalPrice}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Remise: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        if (cart.isLoading)
                          shimmerPlaceholder(
                            context,
                            'chargement...',
                          )
                        else ...[
                          Text(
                            '€${cart.rebate}',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.local_offer,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'À payer: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        cart.isLoading
                            ? shimmerPlaceholder(
                                context,
                                'chargement...',
                              )
                            : Text('€${cart.finalPrice}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
