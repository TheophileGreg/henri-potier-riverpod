import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:henri_potier_riverpod/core/network.dart';

import 'package:henri_potier_riverpod/features/cart/data/remote/commercial_offer_api.dart';
import 'package:henri_potier_riverpod/features/cart/data/repository/commercial_offer_repository_impl.dart';
import 'package:henri_potier_riverpod/features/cart/domain/repositories/commercial_offer_repository.dart';
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_commercial_offers_usecase.dart';
import 'package:henri_potier_riverpod/features/library/data/remote/library_api.dart';
import 'package:henri_potier_riverpod/features/library/data/repository/library_repository_impl.dart';
import 'package:henri_potier_riverpod/features/library/domain/repositories/library_repository.dart';
import 'package:henri_potier_riverpod/features/library/domain/usecases/get_books_usecase.dart';

final GetIt storeLocator = GetIt.instance;

Future<void> init() async {
  storeLocator.registerSingleton(Dio());

  //! Features - Library

  // Api
  storeLocator.registerLazySingleton<LibraryApi>(
    () => LibraryApi(storeLocator(), baseUrl: baseUrl),
  );

  // Repository
  storeLocator.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(libraryApi: storeLocator()),
  );

  // Use cases
  storeLocator.registerLazySingleton(() => GetBooksUseCase(storeLocator()));

  //! Features - Cart

// Api
  storeLocator.registerLazySingleton<CommercialOfferApi>(
    () => CommercialOfferApi(storeLocator(), baseUrl: baseUrl),
  );

  // Repository
  storeLocator.registerLazySingleton<CommercialOfferRepository>(
    () => CommercialOfferRepositoryImpl(commercialOfferApi: storeLocator()),
  );

  // Use cases
  storeLocator
      .registerLazySingleton(() => GetCommercialOffersUseCase(storeLocator()));
}
