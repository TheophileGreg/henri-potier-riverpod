import 'package:go_router/go_router.dart';
import 'package:henri_potier_riverpod/features/cart/presentation/screens/cart_screen.dart';
import 'package:henri_potier_riverpod/features/library/domain/entities/book.dart';
import 'package:henri_potier_riverpod/features/library/presentation/screens/book_details_screen.dart';
import 'package:henri_potier_riverpod/features/library/presentation/screens/library_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'library',
      path: '/',
      builder: (context, state) => const LibraryScreen(),
    ),
    GoRoute(
      name: 'cart',
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      name: 'bookDetails',
      path: '/bookDetails',
      builder: (context, state) {
        final Book book = state.extra as Book;
        return BookDetailsScreen(book: book);
      },
    ),
  ],
);
