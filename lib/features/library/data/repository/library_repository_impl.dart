import 'package:henri_potier_riverpod/features/library/data/remote/library_api.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:henri_potier_riverpod/features/library/domain/repositories/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryApi libraryApi;

  LibraryRepositoryImpl({required this.libraryApi});

  @override
  Future<List<Book>> getBooks() async {
    return await libraryApi.getBooks();
  }
}
