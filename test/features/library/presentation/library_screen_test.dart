import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:henri_potier_riverpod/features/cart/domain/entities/cart_state.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:henri_potier_riverpod/features/library/domain/usecases/get_books_usecase.dart';
import 'package:henri_potier_riverpod/features/library/presentation/providers/library_providers.dart';
import 'package:henri_potier_riverpod/features/library/presentation/screens/library_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'library_screen_test.mocks.dart';

@GenerateMocks([
  CartNotifier,
  GetBooksUseCase,
])
void main() {
  late CartNotifier mockCartNotifier;
  late GetBooksUseCase mockGetBooksUseCase;

  setUp(() {
    GetIt.instance.reset();

    mockGetBooksUseCase = MockGetBooksUseCase();
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
    when(mockGetBooksUseCase.call()).thenAnswer((_) async => [testBook]);
    when(mockCartNotifier.state)
        .thenReturn(const CartState(false, 0, 0, 0, cart: {}));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cartProvider.overrideWith((ref) => mockCartNotifier),
          libraryProvider.overrideWith((ref) async {
            final usecase = mockGetBooksUseCase;
            final books = await usecase();
            return books;
          })
        ],
        child: const MaterialApp(
          home: LibraryScreen(),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 2));
    final addButton = find.byKey(Key('add_to_cart_button_${testBook.isbn}'));
    expect(addButton, findsOneWidget);

    await tester.tap(addButton);
    await tester.pumpAndSettle();

    verify(mockCartNotifier.addBookToCart(testBook)).called(1);
  });

  testWidgets('LibraryScreen meets androidTapTargetGuideline',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(ProviderScope(
        overrides: [cartProvider.overrideWith((ref) => mockCartNotifier)],
        child: const MaterialApp(home: LibraryScreen())));
    await tester.pump(const Duration(seconds: 2));
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    handle.dispose();
  });

  testWidgets('LibraryScreen meets iosTapTargetGuideline',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(ProviderScope(
        overrides: [cartProvider.overrideWith((ref) => mockCartNotifier)],
        child: const MaterialApp(home: LibraryScreen())));
    await tester.pump(const Duration(seconds: 2));
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    handle.dispose();
  });
}
