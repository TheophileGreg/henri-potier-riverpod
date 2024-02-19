import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:henri_potier_riverpod/core/app_router.dart';
import 'package:henri_potier_riverpod/core/injection_container.dart' as di;

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
    return MaterialApp.router(
      routerConfig: router,
      //showSemanticsDebugger: true,
    );
  }
}
