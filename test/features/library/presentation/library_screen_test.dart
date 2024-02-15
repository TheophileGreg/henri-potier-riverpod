import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:nock/nock.dart';

import 'library_screen_test.mocks.dart';

@GenerateMocks([
  CartNotifier,
  GetBooksUseCase,
])
void main() {
  late CartNotifier mockCartNotifier;
  late GetBooksUseCase mockGetBooksUseCase;

  setUpAll(() => {nock.init()});

  setUp(() {
    GetIt.instance.reset();

    mockGetBooksUseCase = MockGetBooksUseCase();
    mockCartNotifier = MockCartNotifier();

    GetIt.instance.registerSingleton<CartNotifier>(mockCartNotifier);

    nock.cleanAll();
  });

  const testBook = Book(
    isbn: "123",
    title: "Test Book",
    price: 10.0,
    cover: "https://example.com/cover.jpg",
    synopsis: ["Test Synopsis"],
  );

  testWidgets('Add book button should call addBookToCart', (tester) async {
    const double screenWidth = 400;
    tester.view.physicalSize = const Size(screenWidth, 600);
    tester.view.devicePixelRatio = 1;
    when(mockGetBooksUseCase.call()).thenAnswer((_) async => [testBook]);
    when(mockCartNotifier.state)
        .thenReturn(const CartState(false, 0, 0, 0, cart: {}));

    final img = await rootBundle.load('assets/harry.jpg');

    final imgBytes = Uint8List.fromList(img.buffer.asUint8List());

    nock("https://example.com").get("/cover.jpg").reply(200, imgBytes);

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
