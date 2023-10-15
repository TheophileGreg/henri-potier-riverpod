import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:henri_potier_riverpod/core/network.dart';

import 'package:henri_potier_riverpod/features/cart/data/remote/commercial_offer_api.dart';
import 'package:henri_potier_riverpod/features/cart/data/repository/commercial_offer_repository_impl.dart';
import 'package:henri_potier_riverpod/features/cart/domain/repositories/commercial_offer_repository.dart';
import 'package:henri_potier_riverpod/features/cart/domain/usecases/get_commercial_offer_usecase.dart';
import 'package:henri_potier_riverpod/features/library/data/remote/library_api.dart';
import 'package:henri_potier_riverpod/features/library/data/repository/library_repository_impl.dart';
import 'package:henri_potier_riverpod/features/library/domain/repositories/library_repository.dart';
import 'package:henri_potier_riverpod/features/library/domain/usecases/get_books_usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton(Dio());

  //! Features - Library

  // Api
  sl.registerLazySingleton<LibraryApi>(
    () => LibraryApi(sl(), baseUrl: baseUrl),
  );

  // Repository
  sl.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(libraryApi: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetBooksUseCase(sl()));

  //! Features - Cart

// Api
  sl.registerLazySingleton<CommercialOfferApi>(
    () => CommercialOfferApi(sl(), baseUrl: baseUrl),
  );

  // Repository
  sl.registerLazySingleton<CommercialOfferRepository>(
    () => CommercialOfferRepositoryImpl(commercialOfferApi: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCommercialOfferUseCase(sl()));
}
