import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/core/injection_container.dart' as di;
import 'package:henri_potier_riverpod/features/library/presentation/screens/library_screen.dart';

void main() async {
  await di.init();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LibraryScreen());
  }
}
