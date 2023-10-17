import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:henri_potier_riverpod/features/library/domain/repositories/library_repository.dart';
import 'package:henri_potier_riverpod/features/library/domain/usecases/get_books_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_books_usescase_test.mocks.dart';

@GenerateMocks([LibraryRepository])
void main() {
  late GetBooksUseCase usecase;
  late LibraryRepository mockLibraryRepository;

  setUp(() async {
    await GetIt.instance.reset();
    mockLibraryRepository = GetIt.instance
        .registerSingleton<LibraryRepository>(MockLibraryRepository());
    usecase = GetBooksUseCase(mockLibraryRepository);
  });

  final tBooks = [
    const Book(
      isbn: "978-1234567890",
      title: "Le Guide du voyageur galactique",
      price: 12.99,
      cover: "https://example.com/cover1.jpg",
      synopsis: ["synopsis 1", "synopsis2"],
    ),
    const Book(
      isbn: "978-0987654321",
      title: "1984",
      price: 9.99,
      cover: "https://example.com/cover2.jpg",
      synopsis: ["synopsis 1", "synopsis2"],
    )
  ];

  test('should get books from the repository', () async {
    when(mockLibraryRepository.getBooks())
        .thenAnswer((_) async => [tBooks[0], tBooks[1]]);

    final result = await usecase();

    expect(result, tBooks);
    verify(mockLibraryRepository.getBooks());
    verifyNoMoreInteractions(mockLibraryRepository);
  });

  test('should throw an exception when there is an error', () async {
    when(mockLibraryRepository.getBooks()).thenThrow(Exception());

    final call = usecase();

    expect(call, throwsException);
    verify(mockLibraryRepository.getBooks());
    verifyNoMoreInteractions(mockLibraryRepository);
  });
}
