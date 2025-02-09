import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_doc/providers/auth/auth_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sync Docs')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  final a = Provider.of<AuthProvider>(context, listen: false);
                  a.logout();
                },
                child: const Text(
                  'Çıkış',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
