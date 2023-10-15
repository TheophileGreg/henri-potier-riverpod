import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/core/injection_container.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:henri_potier_riverpod/features/library/domain/usecases/get_books_usecase.dart';

final libraryProvider = FutureProvider<List<Book>>((ref) async {
  final usecase = sl<GetBooksUseCase>();
  final books = await usecase.execute();
  return books;
});
