import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_doc/bootstrap/bootstrap.dart';
import 'package:sync_doc/presentation/authentication/auth_gate/view/auth_gate_view.dart';
import 'package:sync_doc/providers/auth/auth_provider.dart';

Future<void> main() async => await bootstrap(() => const MyApp());

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
      home: ChangeNotifierProvider(
          create: (context) => AuthProvider(), child: const AuthGateView()),
    );
  }
}
