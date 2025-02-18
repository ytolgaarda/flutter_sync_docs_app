import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';
import 'package:sync_doc/presentation/documents/view/documents_view.dart';
import 'package:sync_doc/providers/auth/providers.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    String userId = 'ff7b7056-1edd-417b-9793-77158b925dd4';

    DocumentModel document5 = DocumentModel(
      id: 'e',
      title: 'Proje Sunumu',
      content: 'Yeni başlatılacak proje için hazırlanan sunum dosyası.',
      update_at: DateTime.now(),
      created_by: userId,
      synced: 1,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        DocumentService().getAllDocumentsFromRemoteDatabase();
      }),
      appBar: AppBar(title: const Text('Sync Docs')),
      body: const DocumentsListWidget(),
    );
  }
}
