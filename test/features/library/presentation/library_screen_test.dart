import 'dart:async';
import 'dart:io';

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
  HttpClient,
  HttpClientRequest,
  HttpClientResponse,
])
void main() {
  late CartNotifier mockCartNotifier;
  late GetBooksUseCase mockGetBooksUseCase;
  late HttpClient mockHttpclient;
  late HttpClientRequest mockHttpclientRequest;
  late HttpClientResponse mockHttpclientResponse;

  setUp(() {
    GetIt.instance.reset();
    mockCartNotifier = MockCartNotifier();
    mockGetBooksUseCase = MockGetBooksUseCase();
    mockHttpclient = MockHttpClient();
    mockHttpclientRequest = MockHttpClientRequest();
    mockHttpclientResponse = MockHttpClientResponse();

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

    when(mockHttpclient.getUrl(Uri.parse('https://example.com/cover.jpg')))
        // .thenThrow(Exception());
        .thenAnswer((_) => Future.value(mockHttpclientRequest));

    when(mockHttpclientRequest.close())
        .thenAnswer((_) => Future.value(mockHttpclientResponse));

    when(mockHttpclientResponse.statusCode).thenReturn(200);

    when(mockHttpclientResponse.contentLength).thenReturn(100);

    when(mockHttpclientResponse.compressionState)
        .thenReturn(HttpClientResponseCompressionState.notCompressed);

    when(mockHttpclientResponse.listen(
      any,
      onDone: anyNamed('onDone'),
      onError: anyNamed('onError'),
      cancelOnError: anyNamed('cancelOnError'),
    )).thenAnswer((Invocation invocation) {
      final onData =
          invocation.positionalArguments[0] as void Function(List<int>);

      return Stream.value(const [1, 2, 3]).listen(onData);
    });

    await HttpOverrides.runZoned(() async {
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
    }, createHttpClient: (_) => mockHttpclient);
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
