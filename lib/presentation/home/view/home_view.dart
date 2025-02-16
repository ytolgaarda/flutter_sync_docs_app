import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';
import 'package:sync_doc/providers/auth/providers.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    String userId = 'ff7b7056-1edd-417b-9793-77158b925dd4';

    DocumentModel document = DocumentModel(
      id: '1',
      title: 'Sample Document',
      content: 'AAAAAThis is the content of the document.',
      update_at: DateTime.now(),
      created_by: userId,
    );

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
              ElevatedButton(
                onPressed: () {
                  DocumentService().addNote(document);
                },
                child: const Text('add note'),
              ),
              ElevatedButton(
                onPressed: () {
                  DocumentService().saveDocumentToSupabase(document);
                },
                child: const Text('yaz '),
              ),
              ElevatedButton(
                onPressed: () {
                  DocumentService().getAllDocumentsFromLocalDb();
                },
                child: const Text('get '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
