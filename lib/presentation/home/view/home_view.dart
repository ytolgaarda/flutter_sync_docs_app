import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sync_doc/providers/auth/providers.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Sync Docs')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  authController.logout();
                },
                child: const Text('Çıkış'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
