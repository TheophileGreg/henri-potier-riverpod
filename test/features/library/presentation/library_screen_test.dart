import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:henri_potier_riverpod/features/cart/domain/entities/cart_state.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:henri_potier_riverpod/features/library/presentation/screens/library_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'library_screen_test.mocks.dart';

@GenerateMocks([CartNotifier])
void main() {
  late CartNotifier mockCartNotifier;

  setUp(() {
    GetIt.instance.reset();

    mockCartNotifier = MockCartNotifier();

    GetIt.instance.registerSingleton<CartNotifier>(mockCartNotifier);
  });
  const testBook = Book(
    isbn: "123",
    title: "Test Book",
    price: 10.0,
    cover: "https://example.com/cover.jpg",
    synopsis: ["Test Synopsis"],
  );

  testWidgets('Add book button should call addBookToCart', (tester) async {
    when(mockCartNotifier.state)
        .thenReturn(const CartState(false, 0, 0, 0, cart: {}));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [cartProvider.overrideWith((ref) => mockCartNotifier)],
        child: const MaterialApp(
          home: LibraryScreen(),
        ),
      ),
    );

    final addButton = find.byIcon(Icons.add);
    expect(addButton, findsOneWidget);

    await tester.tap(addButton);
    await tester.pumpAndSettle();

    verify(mockCartNotifier.addBookToCart(testBook)).called(1);
  });
}
