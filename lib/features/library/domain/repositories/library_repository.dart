import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';

abstract class LibraryRepository {
  Future<List<Book>> getBooks();
}
