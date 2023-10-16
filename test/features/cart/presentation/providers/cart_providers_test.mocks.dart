// Mocks generated by Mockito 5.4.2 from annotations
// in henri_potier_riverpod/test/features/cart/presentation/providers/cart_providers_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:henri_potier_riverpod/features/cart/domain/entities/commercial_offer.dart'
    as _i4;
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_commercial_offers_usecase.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

/// A class which mocks [GetCommercialOffersUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCommercialOffersUseCase extends _i1.Mock
    implements _i2.GetCommercialOffersUseCase {
  MockGetCommercialOffersUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.CommercialOffer>> call({required String? isbns}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#isbns: isbns},
        ),
        returnValue: _i3.Future<List<_i4.CommercialOffer>>.value(
            <_i4.CommercialOffer>[]),
      ) as _i3.Future<List<_i4.CommercialOffer>>);
}
