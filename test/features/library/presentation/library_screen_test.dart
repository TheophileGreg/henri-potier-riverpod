import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:henri_potier_riverpod/features/library/domain/usecases/get_books_usecase.dart';
import 'package:henri_potier_riverpod/features/library/presentation/screens/library_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart';
import 'package:flutter_test/flutter_test.dart';

import 'library_screen_test.mocks.dart';

@GenerateMocks([
  CartNotifier,
  GetBooksUseCase,
])
void main() {
  late CartNotifier mockCartNotifier;

  setUp(() {
    GetIt.instance.reset();
    mockCartNotifier = MockCartNotifier();

    GetIt.instance.registerSingleton<CartNotifier>(mockCartNotifier);
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
