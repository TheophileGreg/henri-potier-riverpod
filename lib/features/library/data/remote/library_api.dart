import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:henri_potier_riverpod/features/library/data/models/book_model.dart';
import 'package:henri_potier_riverpod/core/network.dart';

part 'library_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class LibraryApi {
  factory LibraryApi(Dio dio, {String baseUrl}) = _LibraryApi;

  @GET("/books")
  Future<List<BookModel>> getBooks();
}
