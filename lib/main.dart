import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sync_doc/bootstrap/bootstrap.dart';
import 'package:sync_doc/presentation/authentication/auth_gate/view/auth_gate_view.dart';

Future<void> main() async =>
    await bootstrap(() => const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGateView(),
    );
  }
}
