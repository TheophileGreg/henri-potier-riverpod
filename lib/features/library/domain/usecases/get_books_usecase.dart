import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:henri_potier_riverpod/features/library/domain/repositories/library_repository.dart';

class GetBooksUseCase {
  final LibraryRepository _repository;

  GetBooksUseCase(this._repository);

  Future<List<Book>> call() async {
    return await _repository.getBooks();
  }
}
