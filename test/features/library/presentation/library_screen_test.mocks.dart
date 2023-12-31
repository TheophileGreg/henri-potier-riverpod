// Mocks generated by Mockito 5.4.2 from annotations
// in henri_potier_riverpod/test/features/library/presentation/library_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter_riverpod/flutter_riverpod.dart' as _i4;
import 'package:henri_potier_riverpod/features/cart/domain/entities/cart_state.dart'
    as _i2;
import 'package:henri_potier_riverpod/features/cart/presentation/providers/cart_providers.dart'
    as _i3;
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart'
    as _i6;
import 'package:henri_potier_riverpod/features/library/domain/usecases/get_books_usecase.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:state_notifier/state_notifier.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCartState_0 extends _i1.SmartFake implements _i2.CartState {
  _FakeCartState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CartNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockCartNotifier extends _i1.Mock implements _i3.CartNotifier {
  MockCartNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set onError(_i4.ErrorListener? _onError) => super.noSuchMethod(
        Invocation.setter(
          #onError,
          _onError,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
      ) as bool);

  @override
  _i5.Stream<_i2.CartState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i2.CartState>.empty(),
      ) as _i5.Stream<_i2.CartState>);

  @override
  _i2.CartState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeCartState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.CartState);

  @override
  set state(_i2.CartState? value) => super.noSuchMethod(
        Invocation.setter(
          #state,
          value,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.CartState get debugState => (super.noSuchMethod(
        Invocation.getter(#debugState),
        returnValue: _FakeCartState_0(
          this,
          Invocation.getter(#debugState),
        ),
      ) as _i2.CartState);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i5.Future<void> addBookToCart(_i6.Book? book) => (super.noSuchMethod(
        Invocation.method(
          #addBookToCart,
          [book],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> removeBookFromCart(_i6.Book? book) => (super.noSuchMethod(
        Invocation.method(
          #removeBookFromCart,
          [book],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> updatePrice() => (super.noSuchMethod(
        Invocation.method(
          #updatePrice,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  bool updateShouldNotify(
    _i2.CartState? old,
    _i2.CartState? current,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateShouldNotify,
          [
            old,
            current,
          ],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i4.RemoveListener addListener(
    _i7.Listener<_i2.CartState>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: () {},
      ) as _i4.RemoveListener);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [GetBooksUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetBooksUseCase extends _i1.Mock implements _i8.GetBooksUseCase {
  MockGetBooksUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i6.Book>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i5.Future<List<_i6.Book>>.value(<_i6.Book>[]),
      ) as _i5.Future<List<_i6.Book>>);
}
